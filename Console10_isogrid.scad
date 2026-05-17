// =============================================================================
// CONSOLE10 — Integrated Cheek (v2.3)
// Parametric OpenSCAD source, per Design Document v2.3
//
// Right trapezoid with FRONT slant (operator-facing). Open isogrid pattern
// with regular {3,6} triangular tiling. Front rail AND back rail are both
// integrated into the cheek as 10-32 heat-set insert hole patterns at
// EIA-310 positions. Solid backing strips suppress the isogrid pockets in
// the rail regions so heat-set inserts bear on continuous material.
//
// v2.2 changes from v1.3 / v2.1:
//   - Silhouette flipped: slant is now on the FRONT, not the top
//   - New cheek dimensions: 228.6 × 212.2 / 122.5, slant 26.57° from vertical
//   - Front rail integrated into cheek (was a separate part in v2.1)
//   - Back rail integrated into cheek (was a separate part in v2.1)
//   - Cheek base thickness 6 mm (was 3 mm) — accommodates 10-32 inserts
//   - 1U bottom gap on front rail; 4U mounting; 15 mm top margin
//
// v2.3 changes from v2.2:
//   - Slant angle 26.57 deg -> 30 deg from vertical (= atan(sqrt(3)/3))
//     New angle is parallel to one set of {3,6} isogrid triangle edges
//   - Cascading: back_h 212.20 -> 205.45, top_len 122.50 -> 109.975
//   - No standards or rail-layout changes
// =============================================================================

// -----------------------------------------------------------------------------
// [Geometry — LOCKED per Design Document v2.2 §4]
// -----------------------------------------------------------------------------
bottom_len    = 228.6;     // LOCKED — bottom edge length (mm, 9")
slant_angle_v = 30;        // LOCKED — slant angle from vertical (degrees) = atan(sqrt(3)/3) — aligned to isogrid
top_margin    = 15.0;      // LOCKED — top margin along slant (mm)

// -----------------------------------------------------------------------------
// [Isogrid pattern — §4.3]
// -----------------------------------------------------------------------------
spacing     = 20;          // [10:1:40] isogrid cell side length (mm)
rib         = 2.5;         // [1.5:0.1:5] rib thickness (mm)
pocket_d    = 1.8;         // [0.5:0.1:3] pocket depth into cheek face (mm)
fillet_r    = 1.59;        // [0.5:0.01:3.2] corner fillet radius (mm); 1.59 = 1/8" endmill
through_cut = false;       // cut pockets all the way through panel (open isogrid)
node_hole_r = 0;           // [0:0.05:2.5] optional node hole (0 = solid)
pattern_rot = 0;           // [0,30] pattern orientation

// -----------------------------------------------------------------------------
// [Cheek thickness]
// -----------------------------------------------------------------------------
panel_t     = 6;           // [4:0.5:10] cheek base thickness (mm)
                           //   6 mm chosen to accommodate 6 mm 10-32 heat-set inserts

// -----------------------------------------------------------------------------
// [Rail mounting + perimeter — §4.3, §5, §6]
// -----------------------------------------------------------------------------
perimeter_w     = 25;      // [15:1:35] solid perimeter strip width (mm); rail
                           //   regions and top/bottom panel-attach regions all
                           //   live in this strip — isogrid is clipped to the
                           //   interior, leaving a uniform solid border
hole_diam_10_32 = 4.2;     // [3:0.1:6] 10-32 insert pilot hole diameter (mm)
through_holes   = true;    // rail holes go through cheek (insert installed from interior)

// -----------------------------------------------------------------------------
// [Render quality]
// -----------------------------------------------------------------------------
$fa = 2;
$fs = 0.3;

// =============================================================================
//                                  DERIVED
// =============================================================================
SQRT3 = sqrt(3);
U     = 44.45;             // 1U = 44.45 mm

// Slant unit vectors (in cheek silhouette plane)
slant_x = sin(slant_angle_v);    // 0.4472
slant_y = cos(slant_angle_v);    // 0.8944
// Perpendicular into the cheek interior (CW rotation of slant direction)
perp_x  =  slant_y;              // 0.8944
perp_y  = -slant_x;              // -0.4472

// Rail layout along the slant
front_gap        = U;                                       // 44.45 — 1U gap
front_n_u        = 4;                                       // 4U mounting
front_mount_len  = front_n_u * U;                           // 177.8
front_len        = front_gap + front_mount_len + top_margin; // 237.25

// Back-edge layout (vertical)
back_n_u         = 4;
back_mount_len   = back_n_u * U;                            // 177.8

// Cheek silhouette vertices
back_h  = front_len * slant_y;                              // 212.20
top_len = bottom_len - front_len * slant_x;                 // 122.50
v_front_bot = [0,                          0];
v_back_bot  = [bottom_len,                 0];
v_back_top  = [bottom_len,                 back_h];
v_front_top = [front_len * slant_x,        back_h];

// EIA-310 hole positions within a U (from U bottom)
eia_offsets = [6.35, 22.225, 38.10];

// Isogrid math (carried over from v1.3)
inset_side  = spacing - SQRT3 * rib;
inner_side  = inset_side - 2 * fillet_r * SQRT3;

// =============================================================================
//                               ASSERTIONS
// =============================================================================
assert(inset_side  > 0, "rib too thick for spacing");
assert(inner_side  > 0, "fillet too large for inset triangle");
assert(node_hole_r <= rib, "node_hole_r exceeds rib width");
assert(front_len <= 256,  "front_len exceeds 256 mm bed limit");
assert(bottom_len <= 256, "bottom_len exceeds 256 mm bed limit");
assert(back_h     <= 256, "back_h exceeds 256 mm bed limit");
assert(panel_t    >= 5,   "panel_t too thin for 10-32 heat-set inserts");

echo("=== Console10 cheek v2.2 ===");
echo(str("  bottom = ", bottom_len, " mm"));
echo(str("  back   = ", back_h,     " mm"));
echo(str("  top    = ", top_len,    " mm"));
echo(str("  slant  = ", front_len,  " mm at ", slant_angle_v, "° from vertical"));
echo(str("  thickness = ", panel_t, " mm"));

// =============================================================================
//                              SILHOUETTE (2D)
// =============================================================================
module cheek_silhouette() {
    polygon([v_front_bot, v_back_bot, v_back_top, v_front_top]);
}

// =============================================================================
//                  INTERIOR REGION (silhouette minus perimeter strip)
//
// The isogrid pattern is clipped to this region, leaving a uniform solid
// border of width `perimeter_w` around the entire silhouette. This border
// covers BOTH rail edges (slant + back vertical) AND the top/bottom edges
// (for top/bottom panel attachment via M3 inserts) in one consistent strip.
// =============================================================================
module interior_region_2d() {
    offset(delta = -perimeter_w) cheek_silhouette();
}

// =============================================================================
//                       ISOGRID POCKET PRIMITIVES (2D)
// =============================================================================
module rounded_tri_up(side, r_f) {
    h = side * SQRT3 / 2;
    offset(r = r_f)
        polygon([[-side/2, -h/3], [side/2, -h/3], [0, 2*h/3]]);
}

module rounded_tri_down(side, r_f) {
    h = side * SQRT3 / 2;
    offset(r = r_f)
        polygon([[-side/2, h/3], [0, -2*h/3], [side/2, h/3]]);
}

// =============================================================================
//                     ISOGRID LATTICE (clipped + rails excluded)
// =============================================================================
i_lim = ceil((bottom_len + back_h) / spacing) + 3;
j_lim = i_lim;

module isogrid_2d() {
    intersection() {
        rotate([0, 0, pattern_rot])
        union() {
            for (j = [-j_lim : j_lim], i = [-i_lim : i_lim]) {
                cx = spacing*i + spacing*j/2;
                cy = spacing*j*SQRT3/2;
                translate([cx + spacing/2, cy + spacing*SQRT3/6])
                    rounded_tri_up(inner_side, fillet_r);
                translate([cx + spacing, cy + spacing*SQRT3/3])
                    rounded_tri_down(inner_side, fillet_r);
                if (node_hole_r > 0)
                    translate([cx, cy])
                        circle(r = node_hole_r);
            }
        }
        // Clip to silhouette MINUS the perimeter strip (isogrid lives in interior only)
        interior_region_2d();
    }
}

// =============================================================================
//                       RAIL HOLE PATTERNS (3D cylinders)
// =============================================================================

// Front rail — 12 holes along slant at EIA-310 positions, 4U starting 1U up
module front_rail_holes() {
    hole_h = through_holes ? panel_t + 1 : panel_t - 0.5;
    z_off  = through_holes ? -0.5 : panel_t - hole_h - 0.001;
    for (u_idx = [0 : front_n_u - 1]) {
        u_bot = front_gap + u_idx * U;
        for (e = eia_offsets) {
            s = u_bot + e;
            cx = slant_x * s + perp_x * (perimeter_w / 2);
            cy = slant_y * s + perp_y * (perimeter_w / 2);
            translate([cx, cy, z_off])
                cylinder(d = hole_diam_10_32, h = hole_h);
        }
    }
}

// Back rail — 12 holes along back-vertical at EIA-310 positions, 4U from floor
module back_rail_holes() {
    hole_h = through_holes ? panel_t + 1 : panel_t - 0.5;
    z_off  = through_holes ? -0.5 : panel_t - hole_h - 0.001;
    cx = bottom_len - perimeter_w / 2;
    for (u_idx = [0 : back_n_u - 1]) {
        u_bot = u_idx * U;
        for (e = eia_offsets) {
            cy = u_bot + e;
            translate([cx, cy, z_off])
                cylinder(d = hole_diam_10_32, h = hole_h);
        }
    }
}

// =============================================================================
//                                  CHEEK
// =============================================================================
module cheek() {
    difference() {
        // Cheek base with isogrid pockets (suppressed inside rail strips)
        difference() {
            linear_extrude(height = panel_t)
                cheek_silhouette();
            cut_depth = through_cut ? panel_t + 0.2 : pocket_d;
            cut_z     = through_cut ? -0.1          : panel_t - pocket_d;
            translate([0, 0, cut_z])
                linear_extrude(height = cut_depth + 0.01)
                    isogrid_2d();
        }
        // Rail mounting holes
        front_rail_holes();
        back_rail_holes();
    }
}

cheek();

// =============================================================================
// VARIANT PRESETS (§11.1)
// -----------------------------------------------------------------------------
// C1 (Solid):         set spacing very large so no isogrid pockets generate
// C2 (Open isogrid):  through_cut = true                              ← default
// C3 (Etched isogrid): through_cut = false, pocket_d = 0.4 (shallow surface etch)
// C4 (Sci-fi etched): replace isogrid_2d with custom etching pattern (TBD)
// =============================================================================
