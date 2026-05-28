// =============================================================================
// CONSOLE10 — Cheek (Isogrid)  v3.0
// Trapezoidal right-trapezoid silhouette, slant on FRONT, 30° from vertical.
// 10 mm thick.  Interior face has full-coverage {3,6} isogrid pockets.
// Rail-mount holes are drilled into the slant + back EDGE FACES, perpendicular
// to each edge.
// v3.1 joinery: BOTH the bottom AND top edges have a rabbet groove that
// receives the side ridge of the bottom / top panel (4x4, symmetric joinery).
// (Old v2.4 tab-channels removed.)
// =============================================================================

// ---------- LOCKED PARAMETERS (do not edit without bumping doc rev) -----------
bottom_len    = 228.6;     // bottom edge length, mm
slant_angle_v = 30;        // slant angle from vertical, degrees
top_margin    = 15.0;      // gap at top of slant above the highest mount
panel_t       = 10;        // cheek thickness, mm  (v2.4: was 6)

// Isogrid
spacing      = 20;         // triangle edge length, mm
rib          = 2.5;        // rib width, mm
pocket_d     = 1.8;        // pocket depth, mm  (use through_cut for see-through)
fillet_r     = 1.59;       // inner-corner fillet radius, mm
through_cut  = false;
pattern_rot  = 0;          // isogrid rotation in degrees

// Rail-mount holes (edge-drilled, 10-32)
hole_d_10_32   = 4.2;      // pilot diameter for 10-32 insert, mm
hole_depth     = 8;        // depth into cheek thickness, mm

// Bottom-edge rabbet — receives the bottom panel's side ridge.
// Values MUST match Console10_bottom.scad (ridge_width / ridge_height /
// ridge_inset / ridge_setback). Inset is measured from the EXTERIOR face (Z=0),
// assuming the cheek's exterior is flush with the floor panel's side edge.
ridge_w       = 4;         // ridge width  (across cheek thickness, Z)
ridge_h       = 4;         // ridge height (cut depth up into the bottom edge, Y)
ridge_inset   = 4;         // from exterior face (Z=0) to the ridge outer face
ridge_setback = 20;        // from the front edge (x=0) to the start of the ridge
rabbet_clear  = 0.4;       // fit clearance

// ---------- DERIVED ---------------------------------------------------------
SQRT3 = sqrt(3);
U     = 44.45;             // 1U mm

slant_x = sin(slant_angle_v);   // x-component of slant unit
slant_y = cos(slant_angle_v);   // y-component of slant unit

front_gap     = U;              // 1U gap above front-bottom corner
front_n_u     = 4;              // 4U mount capacity on slant
front_mount_len = front_n_u * U;
front_len     = front_gap + front_mount_len + top_margin;   // slant length

back_n_u      = 4;              // 4U mount capacity on back
back_mount_len = back_n_u * U;

back_h    = front_len * slant_y;                 // back vertical height
top_len   = bottom_len - front_len * slant_x;    // top edge length

// Corner vertices (in cheek's local 2D frame, x=along bottom, y=up)
v_front_bot = [0, 0];
v_back_bot  = [bottom_len, 0];
v_back_top  = [bottom_len, back_h];
v_front_top = [front_len * slant_x, back_h];

// EIA-310 hole offsets within each U
eia_offsets = [6.35, 22.225, 38.10];

// Isogrid inner-triangle size (after subtracting rib + fillet allowances)
inset_side = spacing - SQRT3 * rib;
inner_side = inset_side - 2 * fillet_r * SQRT3;

assert(panel_t >= 5, "panel_t too thin for 10-32 edge-drilled inserts");

echo("=== Console10 cheek v2.4 ===");
echo(str("  thickness     = ", panel_t, " mm"));
echo(str("  back_h        = ", back_h, " mm"));
echo(str("  top_len       = ", top_len, " mm"));
echo(str("  slant_len     = ", front_len, " mm"));

// ---------- MODULES ---------------------------------------------------------

// 2D silhouette (right trapezoid, slant on front)
module cheek_silhouette() {
    polygon([v_front_bot, v_back_bot, v_back_top, v_front_top]);
}

// Isogrid primitives — rounded triangles for the {3,6} tiling
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

// Isogrid 2D - per-triangle filter (v2.5): pockets only where tri fits in silhouette
i_lim = ceil((bottom_len + back_h) / spacing) + 3;
j_lim = i_lim;

// Point-in-silhouette test (right-trapezoid, slant on front-left).
function inside_silhouette(p) =
    p[1] >= 0 &&
    p[0] <= bottom_len &&
    p[1] <= back_h &&
    (slant_y * p[0] - slant_x * p[1]) >= 0;

function tri_up_in(c, s) =
    let(h = s * SQRT3 / 2)
    inside_silhouette([c[0]-s/2, c[1]-h/3]) &&
    inside_silhouette([c[0]+s/2, c[1]-h/3]) &&
    inside_silhouette([c[0],     c[1]+2*h/3]);

function tri_dn_in(c, s) =
    let(h = s * SQRT3 / 2)
    inside_silhouette([c[0]-s/2, c[1]+h/3]) &&
    inside_silhouette([c[0]+s/2, c[1]+h/3]) &&
    inside_silhouette([c[0],     c[1]-2*h/3]);

module isogrid_2d() {
    rotate([0, 0, pattern_rot])
        for (j = [-j_lim : j_lim], i = [-i_lim : i_lim]) {
            cx = spacing*i + spacing*j/2;
            cy = spacing*j*SQRT3/2;
            up_c = [cx + spacing/2, cy + spacing*SQRT3/6];
            dn_c = [cx + spacing, cy + spacing*SQRT3/3];
            if (tri_up_in(up_c, inset_side))
                translate(up_c) rounded_tri_up(inner_side, fillet_r);
            if (tri_dn_in(dn_c, inset_side))
                translate(dn_c) rounded_tri_down(inner_side, fillet_r);
        }
}

// Slant edge holes — drilled perpendicular to the slant face.
// Cylinder axis: rotate from +Z to (sin(slant_angle_v+90°), -cos(...), 0) =
//   (cos(slant_angle_v), -sin(slant_angle_v), 0), i.e. into the cheek body.
// Sequence: cylinder along +Z → rotate [0,90,0] aligns to +X →
//           rotate [0,0,-slant_angle_v] tilts it slant-perpendicular.
module slant_edge_holes() {
    for (u_idx = [0 : front_n_u - 1]) {
        u_bot = front_gap + u_idx * U;
        for (e = eia_offsets) {
            s = u_bot + e;                 // distance along slant from front-bot
            translate([slant_x * s, slant_y * s, panel_t / 2])
                rotate([0, 0, -slant_angle_v])
                    rotate([0, 90, 0])
                        translate([0, 0, -0.1])
                            cylinder(d = hole_d_10_32, h = hole_depth + 0.2, $fn=24);
        }
    }
}

// Back edge holes — drilled perpendicular to the back face (axis: -X into cheek)
module back_edge_holes() {
    for (u_idx = [0 : back_n_u - 1]) {
        u_bot = u_idx * U;
        for (e = eia_offsets) {
            v = u_bot + e;
            // skip any hole that would clip the bottom rabbet groove
            if (v - hole_d_10_32/2 > ridge_h + rabbet_clear) {
                translate([bottom_len, v, panel_t / 2])
                    rotate([0, -90, 0])
                        translate([0, 0, -0.1])
                            cylinder(d = hole_d_10_32, h = hole_depth + 0.2, $fn=24);
            }
        }
    }
}

// Bottom-edge rabbet — groove cut UP into the bottom edge to receive the
// floor panel's side ridge. Runs along the bottom edge (x), positioned across
// the thickness (Z) to match the ridge.
module bottom_rabbet() {
    ridge_len = bottom_len - ridge_setback;
    translate([ridge_setback, -0.01, ridge_inset - rabbet_clear/2])
        cube([ridge_len, ridge_h + rabbet_clear, ridge_w + rabbet_clear]);
}

// Top-edge rabbet — groove cut DOWN into the top edge to receive the top
// panel's side ridge (mirror of bottom_rabbet, runs the full top edge).
module top_rabbet() {
    translate([v_front_top[0], back_h - (ridge_h + rabbet_clear), ridge_inset - rabbet_clear/2])
        cube([top_len, ridge_h + rabbet_clear + 1, ridge_w + rabbet_clear]);
}

// ---------- ASSEMBLED CHEEK -------------------------------------------------
module cheek() {
    difference() {
        // Solid extruded trapezoid
        linear_extrude(height = panel_t)
            cheek_silhouette();
        // Isogrid pockets (or through-cuts) into the interior face (+Z)
        cut_depth = through_cut ? panel_t + 0.2 : pocket_d;
        cut_z     = through_cut ? -0.1 : panel_t - pocket_d;
        translate([0, 0, cut_z])
            linear_extrude(height = cut_depth + 0.01)
                isogrid_2d();
        // Rail-mount holes on slant + back edges
        slant_edge_holes();
        back_edge_holes();
        // v3.1: bottom + top edge rabbets receive the floor / top panel ridges
        bottom_rabbet();
        top_rabbet();
    }
}

cheek();
