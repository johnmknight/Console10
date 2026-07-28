// =============================================================================
// FUNLOGY FLSS1 ("FUNLOGY Speaker") — bounding ENVELOPE for Console10 fit-checks.
//
// One unit. This is the MAX bounding volume per the funlogy.jp spec table (which
// already includes the 30 deg tilt), NOT the true enclosure shape — use it for
// clearance / footprint checks beside the Console10 modules.
//   W 69 x D 132 x H 108 mm  |  ~260 g  |  Φ48 driver, passive-radiator bass
//   14 W (7W x2, 3.6 ohm)  |  3.5 mm audio in  |  USB-A 5V power  |  volume dial
//   front (driver) face = +Y ;  sits on the desk at Z=0.
// =============================================================================

sp_w     = 69;     // width  (X, left-right)
sp_d     = 132;    // depth  (Y, front -> back)
sp_h     = 108;    // height (Z, up)
driver_d = 48;     // Φ48 driver
tilt     = 30;     // front-baffle rake (design feature; lives WITHIN the box)
$fn      = 64;

// optional desk fit-check: two speakers flanking one Console10 module
show_pair = false;
console_w = 253;   // one Console10 module (10" mini-rack width)
pair_gap  = 20;    // speaker <-> console gap

echo(str("FUNLOGY FLSS1 envelope (one unit) ", sp_w, " x ", sp_d, " x ", sp_h, " mm = ",
         sp_w/25.4, " x ", sp_d/25.4, " x ", sp_h/25.4, " in | driver Φ", driver_d,
         " | footprint ", sp_w, " x ", sp_d, " mm"));

module funlogy_envelope() {
    color("Gainsboro")
    difference() {
        cube([sp_w, sp_d, sp_h]);                        // bounding box; front = +Y face
        // Φ48 driver indicator on the front face (real baffle rakes ~30 deg up inside the box)
        translate([sp_w/2, sp_d - 1.5, sp_h*0.56])
            rotate([-90, 0, 0]) cylinder(d = driver_d, h = 5, center = true);
    }
}

module desk_layout() {
    funlogy_envelope();                                                      // left speaker
    color("LightSteelBlue")                                                  // console footprint ref
        translate([sp_w + pair_gap, 0, 0]) cube([console_w, sp_d, 1]);
    translate([sp_w + 2*pair_gap + console_w, 0, 0]) funlogy_envelope();     // right speaker
    row = 2*sp_w + 2*pair_gap + console_w;
    echo(str("Speaker + console + speaker row = ", row, " mm (", row/25.4, " in)"));
}

if (show_pair) desk_layout(); else funlogy_envelope();
