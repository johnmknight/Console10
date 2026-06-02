// =============================================================================
// CONSOLE10 — Speaker assembly fit-check: full enclosure + 2 FLSS1 speakers
// sitting flat in the lower bay, facing the FRONT. (Visualization, not print.)
// =============================================================================
include <Console10_module.scad>      // draws cheeks + floor + top + front insert; gives floor_t, span, ...
show_display = false;                 // remove the existing front display faceplate (the speakers occupy this opening)

// ---- FLSS1 speaker panel (inline so it places cleanly in the module frame) ----
sp_w = 69; sp_d = 132; sp_h = 108;
baffle_v   = 30;
baffle_run = sp_h * tan(baffle_v);
driver_d   = 48;
gap        = 16;
rail_t     = 4;
rail_h     = 50;
lip_h      = 20;
pair_w     = 2*sp_w + gap;
cxs        = [-(sp_w + gap)/2, (sp_w + gap)/2];
spk_y      = 8;          // small setback from the very front edge

// FLSS1: rounded body, flat base, big raked baffle on the front, circular driver.
module spk_wedge() {
    r = 7;   // edge round
    difference() {
        minkowski() {
            translate([-sp_w/2 + r, r, r]) cube([sp_w - 2*r, sp_d - 2*r, sp_h - 2*r]);
            sphere(r, $fn = 24);
        }
        // raked baffle: shear the front-top so the front face leans back baffle_v from vertical
        rotate([-baffle_v, 0, 0]) translate([-sp_w/2 - 5, -300, -8]) cube([sp_w + 10, 300, sp_h*3]);
        // circular driver recess, in the baffle face
        translate([0, baffle_run*0.46, sp_h*0.5])
            rotate([-(90 - baffle_v), 0, 0]) cylinder(d = driver_d, h = 12, center = true, $fn = 40);
    }
}
module spk_rail(x) { translate([x - rail_t/2, 0, 0]) cube([rail_t, sp_d, rail_h]); }

// panel removed — just the two speaker placeholders for now
module speaker_panel() {
    for (x = cxs) color("DimGray") translate([x, 0, 0]) spk_wedge();
}

// drop it onto the floor top (world Z = floor_t), at the front, facing -Y
translate([0, spk_y, floor_t]) speaker_panel();
