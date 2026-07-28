// =============================================================================
// CONSOLE10 — Blank 2U Faceplate  v0.1
//
// A featureless 2U filler panel. Bolts to the cheek SLANT inserts via the
// standard 2-per-side hole pattern. Nothing on the front face. Use for empty
// rack bays or as a starting point for a custom one-off panel.
// =============================================================================

// ---------- module geometry the plate must mate to ----------
panel_width   = 253;      // 10" mini-rack width
cheek_thick   = 10;
slant_angle   = 30;
U             = 44.45;
interior_half = panel_width/2 - cheek_thick;   // 116.5
cheek_ctr_x   = interior_half + cheek_thick/2; // 121.5

// ---------- flat plate ----------
n_u      = 2;
plate_w  = 253;
plate_h  = n_u * U;       // 88.9
plate_t  = 3;             // uniform thickness

// ---------- slant-insert mount holes ----------
// 2U plate spans s=0..88.9 along the slant. Only U-row 0 has cheek holes that
// fit on the plate: 50.80, 66.675, 82.55. Use the wide pair (50.80, 82.55)
// for the strongest vertical grip.
mount_y      = [50.80, 82.55];
m10_32_clear = 5.5;

show_on_slant = false;
floor_t       = 6;        // bottom-panel slab thickness (for fit-check)

$fn = 48;

echo(str("BLANK FACEPLATE v0.1 ", plate_w, " x ", plate_h, " (", n_u, "U) t", plate_t,
         " | mounts ", len(mount_y)*2, " (M10-32 clr ", m10_32_clear, ")"));

// =============================================================================
// PANEL — flat 2U 3 mm slab with the 4 slant-insert mount holes.
// =============================================================================
module panel() {
    difference() {
        translate([-plate_w/2, 0, 0]) cube([plate_w, plate_h, plate_t]);
        for (sx = [-cheek_ctr_x, cheek_ctr_x])
            for (y = mount_y)
                translate([sx, y, -1]) cylinder(d = m10_32_clear, h = plate_t + 2);
    }
}

// Fit-check: lay the flat plate onto the 30 deg slant.
module blank_on_slant() {
    translate([0, 0, floor_t])
        rotate([90 - slant_angle, 0, 0])
            color("Gainsboro") panel();
}

// Public entry the module assembly calls:
module blank_faceplate_on_slant() { blank_on_slant(); }

if (show_on_slant) blank_on_slant();
else               color("Gainsboro") panel();
