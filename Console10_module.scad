// =============================================================================
// CONSOLE10 — Module Assembly  v3.0   (fit-check / visualization, NOT for print)
//
// Imports the four parametric parts via use<> and places them in the module.
// World frame:  X = width (left-right),  Y = depth (front-back),  Z = up.
//
// Parts are colored:  cheeks = steel blue, bottom = khaki, top = salmon,
// front insert = pale green.
// =============================================================================

use <Console10_isogrid.scad>           // cheek()
use <Console10_bottom.scad>            // bottom_panel()
use <Console10_top.scad>               // top_panel()
use <Console10_front_insert.scad>      // front_insert()
use <Console10_display_faceplate.scad> // faceplate_on_slant()
use <Console10_lower_blank_faceplate.scad> // lower_blank_faceplate_on_slant()
use <Console10_macropad_pair_faceplate.scad> // macropad_pair_on_slant()
use <Console10_slant_cap.scad>         // slant_cap_on_slant()

// ---- key dimensions (kept equal to the part files) ----
floor_w     = 253;          // bottom/top width (10" mini-rack)
floor_d     = 228.6;        // module depth
floor_t     = 6;            // floor slab thickness
cheek_t     = 10;           // cheek thickness
back_h      = 205.45;       // cheek back-edge height
front_top_x = 237.25 * sin(30);   // = 118.625  (depth of the front-top corner)

hw           = floor_w / 2;       // 126.5
cheek_base_z = floor_t;           // cheeks rest on the floor slab top

// nudges for the loosely-placed parts (tune live in the GUI)
top_z_nudge = 0;
front_y_nudge = 0;     // slide the front insert front/back
front_z_nudge = 0;     // raise/lower the front insert
show_front = false;    // hidden this session — display faceplate occupies the front
show_display = false;  // Elecrow faceplate hidden (photo uses a GeeekPi monitor, different size/position)
show_lower_blank = false; // 2U blank filler beneath the display (off: MacroPad occupies it)
show_macropad   = true;  // twin-MacroPad panel, TOP at the 6th-7th slant-hole midpoint (s=133.35)
show_cheeks     = true;  // off -> clean slant profile (no near cheek blocking the side view)

slant_angle    = 30;        // front slant, degrees from vertical (matches the parts)
// Mount the panel at the HIGHEST cheek slant insert: the faceplate's top screw
// (plate-local 127.00) lands on the topmost cheek hole
// s = front_gap + (front_n_u-1)*U + top_EIA = 44.45 + 3*44.45 + 38.10 = 215.90.
panel_slant_up = (44.45 + 3*44.45 + 38.10) - 127.00;   // = 88.90 mm (2U up); lower screw -> 139.70
span = floor_w - 2*cheek_t;            // interior width between cheeks (~233)
front_height = 38;                     // front insert vertical leg
front_depth  = front_height * tan(30); // 21.94  (30deg face)

// ---- stand a cheek up: local (x=depth, y=height, z=thickness) -> world ----
module cheek_stand() { rotate([0,0,90]) rotate([90,0,0]) cheek(); }

// Cheeks (right is mirrored). Exterior faces flush with the floor side edges.
if (show_cheeks) {
color("LightSteelBlue") translate([-hw, 0, cheek_base_z]) cheek_stand();
color("LightSteelBlue") translate([ hw, 0, cheek_base_z]) mirror([1,0,0]) cheek_stand();
}

// Bottom floor (already centered on X, front edge at Y=0).
color("Khaki") bottom_panel();

// Top — slab + side ridges (same joinery as the bottom). Flipped so the ridges
// point DOWN into the cheek top-edge rabbets. Covers the top edge
// (worldY = front_top_x .. floor_d), sitting on the cheek tops.
top_slab = 6;
color("Salmon")
    translate([0, front_top_x, cheek_base_z + back_h + top_slab + top_z_nudge])
        mirror([0, 0, 1])
            top_panel();

// Front insert — sits ON the floor, at the FRONT, spanning BETWEEN the cheeks.
// Flipped front-to-back (mirror about its depth axis) so the 30deg hypotenuse
// leans back from the front-bottom corner, flush with the cheek slant.
if (show_front)
    color("PaleGreen")
        translate([-span/2, front_depth + front_y_nudge, cheek_base_z + front_z_nudge])
            mirror([0, 1, 0])
                rotate([0, 0, 90])
                    front_insert();

// Display faceplate — Elecrow RC070 7" panel, mounted FLAT on the front 30deg
// slant (the plate tilts to the slant, the flush monitor goes with it). Bolts to
// the cheek slant inserts; the faceplate file already places it in this frame.
if (show_display)
    color("Gainsboro")
        translate([0, sin(slant_angle) * panel_slant_up, cos(slant_angle) * panel_slant_up])
            faceplate_on_slant();

// Lower blank filler — closes the 2U of slant BENEATH the display. It mounts at
// the slant base (s=0..88.9), so its own *_on_slant placement already lands it
// flush under the display's bottom edge — no up-slant shift needed.
if (show_lower_blank)
    color("Silver") lower_blank_faceplate_on_slant();

// Twin-MacroPad panel — TOP edge placed halfway between the 6th (127.00) and 7th
// (139.70) cheek slant holes => s = 133.35. As a 3U panel its base lands at s = 0
// (front-bottom corner); mount holes (50.80, 127.00) hit the 1st & 6th cheek holes.
if (show_macropad)
    macropad_pair_on_slant(0);   // base at slant s=0 -> top at s=133.35

// Slant gap cap — glue-on filler closing the slant between the top panel and the
// top of the display panel (laps 3 mm over the panel).
color("Plum") slant_cap_on_slant();
