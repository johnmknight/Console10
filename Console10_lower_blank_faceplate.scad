// =============================================================================
// CONSOLE10 — Lower Blank Faceplate (under-display filler)  v0.1
//
// A featureless 2U filler that closes the front slant BENEATH the display
// faceplate (Console10_display_faceplate.scad). The display is mounted at the
// highest slant insert and occupies the TOP 3U of the front slant
// (along-slant s = 88.9 .. 222.25); this panel fills the remaining 2U below it
// (s = 0 .. 88.9), bolting to the cheek slant inserts via the standard
// 2-per-side hole pattern.
//
// To read as a SET with the display above it, this panel carries the same {3,6}
// isogrid side columns (same X, spacing, rib, fillet). Set show_isogrid = false
// for a plain slab. No device cutouts — pure filler.
//
// Local frame (also the print orientation):
//   X = plate width,  Y = up the plate (= up the cheek slant),  Z = thickness.
//   +Z = front / operator side.  Front face at Z = plate_t, back at Z = 0.
// =============================================================================

// ---------- module geometry the plate must mate to ----------
panel_width   = 253;      // 10" mini-rack width
cheek_thick   = 10;
slant_angle   = 30;
U             = 44.45;
interior_half = panel_width/2 - cheek_thick;   // 116.5
cheek_ctr_x   = interior_half + cheek_thick/2; // 121.5 (slant insert X centerline)

// ---------- flat plate ----------
n_u      = 2;
plate_w  = 253;           // full module width (sides flush with the cheek outers)
plate_h  = n_u * U;       // 88.9 — fills the slant beneath the display
plate_t  = 3;             // uniform panel thickness

// ---------- slant-insert mount holes ----------
// The 2U plate spans s = 0 .. 88.9 along the slant; only U-row 0 has cheek holes
// that land on the plate (50.80, 66.675, 82.55). Use the wide pair (50.80, 82.55)
// for the strongest vertical grip. (s = 22.225 is inside the front_gap and has no
// cheek hole — don't use it.)
mount_y      = [50.80, 82.55];
m10_32_clear = 5.5;       // 10-32 clearance

// ---------- isogrid side detail (matches Console10_display_faceplate) ----------
show_isogrid = true;      // false -> plain blank slab
iso_spacing  = 20;   iso_rib = 2.5;   iso_fillet = 1.59;   // cheek values
iso_pocket   = 1.5;       // shallow FRONT pocket into the 3 mm face
iso_col_x    = 100;       // column centre X (mirrored ±) — same column as the display
iso_y0       = 8;    iso_y1 = plate_h - 8;     // column Y span (8 mm margins top/bottom)
SQRT3f       = sqrt(3);
iso_inset    = iso_spacing - SQRT3f*iso_rib;
iso_inner    = iso_inset - 2*iso_fillet*SQRT3f;

show_on_slant = false;    // true = fit-check: tilt the flat plate onto the slant
floor_t       = 6;        // bottom-panel slab thickness (for the fit-check placement)

$fn = 48;

echo(str("LOWER BLANK FACEPLATE v0.1 ", plate_w, " x ", plate_h, " (", n_u, "U) t", plate_t,
         " | isogrid=", show_isogrid, " | mounts ", len(mount_y)*2, " (M10-32 clr ", m10_32_clear, ")"));

// ---- isogrid primitives (same {3,6} alternating-triangle field as the display) ----
module r_tri_up(side, rf) { h = side*SQRT3f/2; offset(r=rf) polygon([[-side/2,-h/3],[side/2,-h/3],[0,2*h/3]]); }
module r_tri_dn(side, rf) { h = side*SQRT3f/2; offset(r=rf) polygon([[-side/2,h/3],[0,-2*h/3],[side/2,h/3]]); }

module iso_field(n = 6)
    for (j = [-n:n], i = [-n:n])
        let (fx = iso_spacing*i + iso_spacing*j/2, fy = iso_spacing*j*SQRT3f/2) {
            translate([fx + iso_spacing/2, fy + iso_spacing*SQRT3f/6]) r_tri_up(iso_inner, iso_fillet);
            translate([fx + iso_spacing,   fy + iso_spacing*SQRT3f/3]) r_tri_dn(iso_inner, iso_fillet);
        }

// one column on side sx (±1): the field, clipped to a single-triangle-wide strip
module iso_column_2d(sx) intersection() {
    translate([sx*iso_col_x, plate_h/2]) iso_field();
    translate([sx*iso_col_x - iso_spacing/2, iso_y0]) square([iso_spacing, iso_y1 - iso_y0]);
}

// =============================================================================
// PANEL — flat 2U 3 mm slab, 4 slant-insert mount holes, optional isogrid pockets.
// Front face at Z = plate_t, back at Z = 0.
// =============================================================================
module panel() {
    difference() {
        // the slab
        translate([-plate_w/2, 0, 0]) cube([plate_w, plate_h, plate_t]);

        // slant-insert mount screws — 2 per side, straight through
        for (sx = [-cheek_ctr_x, cheek_ctr_x])
            for (y = mount_y)
                translate([sx, y, -1]) cylinder(d = m10_32_clear, h = plate_t + 2);

        // isogrid side detail: 1 column each side, shallow FRONT pockets
        if (show_isogrid)
            translate([0, 0, plate_t - iso_pocket]) linear_extrude(iso_pocket + 0.1)
                for (sx = [-1, 1]) iso_column_2d(sx);
    }
}

// Fit-check: lay the flat plate onto the 30 deg slant at the slant BASE (s=0) —
// directly beneath the display faceplate (which the assembly shifts 88.9 up-slant).
module lower_blank_on_slant() {
    translate([0, 0, floor_t])
        rotate([90 - slant_angle, 0, 0])
            color("Gainsboro") panel();
}

// Public entry the module assembly calls:
module lower_blank_faceplate_on_slant() { lower_blank_on_slant(); }

if (show_on_slant) lower_blank_on_slant();
else               color("Gainsboro") panel();
