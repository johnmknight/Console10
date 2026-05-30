// =============================================================================
// CONSOLE10 — LCD Simple Faceplate  v0.1  (3U, single 84.1 × 84.1 cutout)
//
// 3U flat 3 mm faceplate that bolts to the cheek SLANT inserts. Single square
// cutout sized for an LCD. No rear sleeve, no clips, no other features.
//
// Origin: split off 2026-05-30 from the multi-device aux faceplate. The other
// devices (CF reader / SD holder / USB-C) moved to
// `Console10_aux_2u_faceplate.scad`.
// =============================================================================

// ---------- module geometry the plate must mate to ----------
panel_width   = 253;
cheek_thick   = 10;
slant_angle   = 30;
U             = 44.45;
interior_half = panel_width/2 - cheek_thick;   // 116.5
cheek_ctr_x   = interior_half + cheek_thick/2; // 121.5

// ---------- flat plate ----------
n_u      = 3;             // 3U faceplate (extends slant base to top)
plate_w  = 253;
plate_h  = n_u * U;       // 133.35
plate_t  = 3;

// ---------- LCD cutout ----------
lcd_w   = 84.1;           // panel-face width
lcd_h   = 84.1;           // panel-face height
lcd_cx  = 0;              // centered horizontally
lcd_cy  = plate_h/2;      // centered vertically

// ---------- slant-insert mount holes ----------
mount_y      = [50.80, 127.00];
m10_32_clear = 5.5;

show_on_slant = false;
floor_t       = 6;

$fn = 48;

echo(str("LCD SIMPLE FACEPLATE v0.1 ", plate_w, " x ", plate_h, " (", n_u, "U) t", plate_t,
         " | LCD cutout ", lcd_w, "x", lcd_h, " @ x=", lcd_cx, " y=", lcd_cy));

// =============================================================================
// PANEL
// =============================================================================
module panel() {
    difference() {
        translate([-plate_w/2, 0, 0]) cube([plate_w, plate_h, plate_t]);

        // LCD cutout
        translate([lcd_cx, lcd_cy, plate_t/2])
            cube([lcd_w, lcd_h, plate_t + 2], center = true);

        // Slant-insert mount screws — 2 per side
        for (sx = [-cheek_ctr_x, cheek_ctr_x])
            for (y = mount_y)
                translate([sx, y, -1]) cylinder(d = m10_32_clear, h = plate_t + 2);
    }
}

// Fit-check: tilt onto 30° slant.
module lcd_on_slant() {
    translate([0, 0, floor_t])
        rotate([90 - slant_angle, 0, 0])
            color("Gainsboro") panel();
}

// Public entry:
module lcd_simple_faceplate_on_slant() { lcd_on_slant(); }

if (show_on_slant) lcd_on_slant();
else               color("Gainsboro") panel();
