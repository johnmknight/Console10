// =============================================================================
// CONSOLE10 — Slant gap cap  (TALL variant: +3 mm vertical)
//
// Copy of Console10_slant_cap.scad, extended 3 mm taller VERTICALLY. The extra
// height is added at the BOTTOM edge (top stays trimmed flush with the top panel).
//
// A glue-on filler that closes the gap on the front 30-deg slant between the TOP
// panel and the TOP of the display faceplate (now mounted at the highest slant
// inserts). It follows the slant profile, is flush with the 3 mm display panel
// front, and extends 3 mm DOWN over the panel top (a lap that hides the seam).
// Glued to the top; not screwed.
//
// Local frame (= print orientation, lay it flat):
//   X = width,  Y = up the slant,  Z = thickness  (+Z = operator/front side).
// =============================================================================

// ---- shared geometry (kept equal to the module + faceplate) ----
slant_angle = 30;          // front slant, degrees from vertical
U           = 44.45;       // 1U
floor_t     = 6;           // bottom-panel slab thickness (slant seat reference)
front_gap   = U;           // 1U gap above the front-bottom corner
front_n_u   = 4;           // 4U slant mount capacity
top_margin  = 15;          // gap at the top of the slant above the highest mount
front_len   = front_gap + front_n_u * U + top_margin;   // 237.25 — slant length
back_h      = front_len * cos(slant_angle);             // 205.45 — cheek back-edge height
top_slab    = 6;                                        // top-panel slab thickness
top_top_z   = floor_t + back_h + top_slab;             // 217.45 — TOP of the top panel

// ---- display panel placement it caps (must match Console10_module.scad) ----
plate_h        = 3 * U;        // 133.35 — display faceplate height (3U)
panel_slant_up = (front_gap + (front_n_u - 1)*U + 38.10) - 127.00;  // 88.90 (highest-mount shift)
panel_top_s    = panel_slant_up + plate_h;     // 222.25 — panel top, along slant

// ---- cap ----
cap_w     = 253;           // full module width (flush with the cheek outer faces)
cap_t     = 3;             // thickness, flush with the display panel front
clr       = 2;             // base clearance above the panel top
extra_v   = 3;             // THIS VARIANT: extend 3 mm taller vertically, added at the bottom
cap_bot   = panel_top_s + clr - extra_v / cos(slant_angle);   // bottom edge drops 3 mm vertically
// run the plate up PAST the top of the top panel; the placement trims it flat there
cap_top_s = (top_top_z - floor_t) / cos(slant_angle) + 8;
cap_len   = cap_top_s - cap_bot;

$fn = 48;

echo(str("SLANT CAP  panel_top_s=", panel_top_s, "  cap_bot=", cap_bot,
         "  clearance_above_panel=", cap_bot - panel_top_s, " mm",
         "  top trimmed @ z=", top_top_z));

// raw plate in the local (print) frame, oversized at the top
module slant_cap() {
    translate([-cap_w/2, 0, 0]) cube([cap_w, cap_len, cap_t]);
}

// placed onto the slant (same tilt + seat as the faceplate), then TRIMMED flat at
// the top so the top face is horizontal + flush with the top of the top panel.
module slant_cap_on_slant() {
    difference() {
        translate([0, sin(slant_angle) * cap_bot, cos(slant_angle) * cap_bot])
            translate([0, 0, floor_t])
                rotate([90 - slant_angle, 0, 0])
                    slant_cap();
        translate([0, 0, top_top_z + 500]) cube([cap_w + 20, 2000, 1000], center = true);
    }
}

// Print orientation: undo the slant placement so the flat back lands on the bed
// (3 mm tall, with the angled trimmed top as an edge).
module slant_cap_for_print() {
    rotate([-(90 - slant_angle), 0, 0])
        translate([0, 0, -floor_t])
            translate([0, -sin(slant_angle) * cap_bot, -cos(slant_angle) * cap_bot])
                slant_cap_on_slant();
}

// Render: on-slant preview by default; -D print_mode=true for the flat print export.
print_mode = false;
if (print_mode) slant_cap_for_print();
else            slant_cap_on_slant();
