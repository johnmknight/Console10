// =============================================================================
// CONSOLE10 — Lower Speaker Panel  v0.2  (2x FUNLOGY FLSS1)
//
// The FLSS1 is a WEDGE: it sits FLAT on its base and its baffle is already
// raked ~30 deg so the driver aims up at the seated user. So we do NOT tilt the
// speakers — they sit flat in the lower bay; the panel is just thin rails that
// locate them and REST ON THE CONSOLE FLOOR, plus a low front lip.
//
// Frame: z=0 = console floor TOP (world Z=6); console front at Y=0, back +Y;
// X = width, centered. Interior between cheeks = 233.
// =============================================================================

// ---- console interior refs ----
interior_w = 233;

// ---- FLSS1 wedge envelope ----
sp_w      = 69;
sp_d      = 132;
sp_h      = 108;
baffle_v  = 30;                       // built-in baffle rake, from vertical
baffle_run = sp_h * tan(baffle_v);    // 62.4 — how far the baffle top sets back
driver_d  = 48;
gap       = 16;                       // between the two speakers

// ---- locating rails / front lip ----
rail_t  = 4;       // thin plate thickness
rail_h  = 50;      // low side-rail height (locates the base, clears body + dial)
front_h = 20;      // low front lip
$fn = 56;

pair_w = 2*sp_w + gap;
cxs    = [-(sp_w + gap)/2, (sp_w + gap)/2];

echo(str("LOWER SPEAKER PANEL v0.2 — 2x FLSS1 (flat, ", baffle_v, " deg baffle) ",
         sp_w, "x", sp_d, "x", sp_h, " | pair ", pair_w, " mm | rails h", rail_h));

// FLSS1 as a flat-sitting wedge: full box minus the front-top prism so the
// front face is the raked baffle (front-bottom edge at Y=0, baffle top set back).
module spk_wedge() {
    r = 7;   // rounded edges
    difference() {
        minkowski() {
            translate([-sp_w/2 + r, r, r]) cube([sp_w - 2*r, sp_d - 2*r, sp_h - 2*r]);
            sphere(r, $fn = 24);
        }
        // raked baffle: shear the front-top so the front face leans back baffle_v from vertical
        rotate([-baffle_v, 0, 0]) translate([-sp_w/2 - 5, -300, -8]) cube([sp_w + 10, 300, sp_h*3]);
        // circular driver recess in the baffle
        translate([0, baffle_run*0.46, sp_h*0.5])
            rotate([-(90 - baffle_v), 0, 0]) cylinder(d = driver_d, h = 12, center = true, $fn = 40);
    }
}
module spk(x) { translate([x, 0, 0]) spk_wedge(); }   // sits FLAT on the floor

// thin vertical rail resting on the floor, running the speaker depth
module rail(x) { translate([x - rail_t/2, 0, 0]) cube([rail_t, sp_d, rail_h]); }

module lower_speaker_panel() {
    color("Gainsboro") {
        // side rails: outer-L, center (in the gap), outer-R
        rail(-pair_w/2);              // left outer
        rail(0);                      // center divider
        rail( pair_w/2);              // right outer
        // low front lip across the pair
        translate([-pair_w/2, -rail_t, 0]) cube([pair_w, rail_t, front_h]);
    }
    // speaker mocks (fit-check)
    for (x = cxs) color("DimGray", 0.9) spk(x);
}

// panel removed — just the two FLSS1 placeholders (orbit / side view shows the profile)
for (x = cxs) color("DimGray") spk(x);
