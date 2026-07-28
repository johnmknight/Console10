// =============================================================================
// CONSOLE10 — 4-wide layout  (fit-check / visualization, NOT for print)
//
// Renders 4 Console10 modules side by side, sharing the same Y/Z frame so the
// row sits with all floors and tops aligned. At floor_w = 253 mm per module,
// 4 fit in a 3'11" (1193.8 mm) opening with ~180 mm (~7 in) of slack.
//
// Side-by-side means cheek-to-cheek: adjacent modules' outer cheek faces are
// flush against each other. No shared wall — two 10 mm cheeks back-to-back at
// each module boundary, like a row of 10" mini-rack chassis on a shelf.
// =============================================================================

use <Console10_isogrid.scad>           // cheek()
use <Console10_bottom.scad>            // bottom_panel()
use <Console10_top.scad>               // top_panel()
use <Console10_front_insert.scad>      // front_insert()
use <Console10_display_faceplate.scad> // faceplate_on_slant()

// ---- shared dims (kept equal to Console10_module.scad) ----
floor_w      = 253;          // 10" mini-rack width
floor_d      = 228.6;
floor_t      = 6;
cheek_t      = 10;
back_h       = 205.45;
front_top_x  = 237.25 * sin(30);   // 118.625
hw           = floor_w / 2;        // 126.5
cheek_base_z = floor_t;
span         = floor_w - 2*cheek_t;
front_height = 38;
front_depth  = front_height * tan(30);
top_slab     = 6;

// ---- row controls ----
count        = 4;            // modules side by side
show_front   = false;        // hide front insert (display faceplate covers the front)
show_display = true;         // show the Elecrow faceplate on each module

// ---- single-module assembly ----
module cheek_stand() { rotate([0,0,90]) rotate([90,0,0]) cheek(); }

module console10() {
    color("LightSteelBlue") translate([-hw, 0, cheek_base_z]) cheek_stand();
    color("LightSteelBlue") translate([ hw, 0, cheek_base_z]) mirror([1,0,0]) cheek_stand();
    color("Khaki") bottom_panel();
    color("Salmon")
        translate([0, front_top_x, cheek_base_z + back_h + top_slab])
            mirror([0, 0, 1])
                top_panel();
    if (show_front)
        color("PaleGreen")
            translate([-span/2, front_depth, cheek_base_z])
                mirror([0, 1, 0])
                    rotate([0, 0, 90])
                        front_insert();
    if (show_display)
        color("Gainsboro") faceplate_on_slant();
}

// ---- the row ----
// Center the row on X=0. Module i sits at center xi = (i - (count-1)/2) * floor_w.
for (i = [0 : count - 1])
    translate([(i - (count - 1) / 2) * floor_w, 0, 0])
        console10();

echo(str("CONSOLE10 4-WIDE — ", count, " x ", floor_w, " mm = ",
         count * floor_w, " mm (",
         count * floor_w / 25.4, " in) wide; fits in 3'11\" (1193.8 mm) with ",
         1193.8 - count * floor_w, " mm slack"));
