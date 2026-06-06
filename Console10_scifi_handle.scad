// Console10 — sci-fi grab handle (parametric module), v4
// ----------------------------------------------------------------------------
// Dog-bone genre handle: wide angular END BLOCKS, diagonal tapers, a thin ribbed
// SPINE raised on ramp-arms with open finger space behind it. Faux bolts are
// DECORATIVE surface detail only (no holes) — the handle is printed as part of
// the host model, so there's nothing to fasten. Original geometry, genre-inspired.
//
// Mount face = z=0; handle stands toward +z; long axis = Y. Defaults are sized to
// sit flush across a 41.5 mm Gridfinity bin side. `use <>` this from an assembly.
// ----------------------------------------------------------------------------

module scifi_handle(
  L        = 40,    // overall length (Y) — set to the side it mounts flush across
  W        = 16,    // end-block width (X)
  SW       = 7,     // spine width (the thin middle)
  BLK      = 8,     // end-block length (each end)
  bh       = 5.5,   // end-block height off the mount
  TAP      = 6,     // diagonal taper run (block -> spine)
  standoff = 13,    // spine-centre height off the mount (finger gap below it)
  sw_t     = 6,     // spine thickness (z)
  cham     = 1.2,   // hard-surface chamfer
  bolt_d   = 3.4,   // faux bolt head diameter
  ribs     = 9,     // rib count
  rib_d    = 1.1,   // rib groove cutter dia
  bolts    = true,  // decorative bolts on/off
  fn       = 48
) {
  $fn = fn;
  spine_hy = L/2 - BLK - TAP;        // half-length of the straight spine
  rib_span = max(4, 2*spine_hy - 2);

  module cbox(l, w, h, c) {          // crisp chamfered box (45-deg bevels)
    hull() {
      cube([l - 2*c, w,        h       ], center = true);
      cube([l,        w - 2*c, h       ], center = true);
      cube([l,        w,        h - 2*c], center = true);
    }
  }
  module bolt() {                    // decorative washer pad + hex socket (no through-hole)
    difference() {
      cylinder(d = bolt_d + 1.4, h = 1.0);
      translate([0, 0, 0.4]) cylinder(d = bolt_d * 0.62, h = 1.0, $fn = 6);
    }
  }
  module block(s) {
    yc = s * (L/2 - BLK/2);
    difference() {
      translate([0, yc, bh/2]) cbox(W, BLK, bh, cham);
      translate([0, yc, bh - 0.4]) difference() {     // recessed panel border
        cube([W - 4,   BLK - 4,   1.2], center = true);
        cube([W - 7.5, BLK - 7.5, 3.0], center = true);
      }
    }
    if (bolts) for (sx = [-1, 1])
      translate([sx * (W/2 - 3.6), s * (L/2 - 3.4), bh]) bolt();
  }
  module arm(s) {                    // diagonal ramp: block (W, low) -> spine (SW, raised)
    hull() {
      translate([0, s * (L/2 - BLK + 1.5), bh - 1.5]) cbox(W,  3, 5,    cham);
      translate([0, s * spine_hy,          standoff]) cbox(SW, 3, sw_t, cham);
    }
  }
  module spine() {
    difference() {
      translate([0, 0, standoff]) cbox(SW, 2 * spine_hy, sw_t, cham);
      for (i = [0 : ribs - 1]) {
        y = -rib_span/2 + i * (rib_span / (ribs - 1));
        translate([0, y, standoff + sw_t/2]) rotate([0, 90, 0])
          cylinder(d = rib_d, h = SW + 2, center = true, $fn = 16);
      }
    }
  }
  block(1); block(-1); arm(1); arm(-1); spine();
}

scifi_handle();   // standalone preview (ignored when this file is `use`d)
