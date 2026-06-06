// Console10 — SD card holder + a pair of basic U-shaped grab handles (one part)
// ----------------------------------------------------------------------------
// Seats into the recess in the Console10 media panel; lift it out by two simple
// U (staple) handles rising 10 mm above the top of the two side walls. Uniform
// 3 mm square stock throughout. Prints as one body. SD slots down the middle
// stay clear (handles sit at the side edges).
// ----------------------------------------------------------------------------

STL    = "C:/3d files/Gridfinity/1x1x4_sd_card_holder_7.stl";
HALF   = 20.75;   // holder half-width (STL spans -20.75..20.75 in X and Y)
TOP    = 26.8;    // top face Z (STL max)

STOCK  = 3;       // handle bar/leg width in the handle plane (rise & span)
THICK  = STOCK + 1;   // depth into the wall (the +1 mm grows toward the interior)
RISE   = 10;      // how far the bar extends UP above the wall top
SPAN   = 2*HALF - STOCK;   // legs at the ends -> bar runs the ENTIRE length of the holder (flush)
DROP   = 16;      // how far the legs extend DOWN into the solid wall (no floating overhang)
BEND   = 4;       // length of each 45-degree corner bend at the top
X_OFF  = HALF - THICK/2;   // keep the OUTER face flush at the edge; extra thickness goes inboard

// U-handle with two 45-deg bends at the top: vertical legs -> 45-deg kick-in ->
// shorter top bar -> 45-deg -> leg. STOCK in the handle plane, THICK into the wall.
// Built spanning X, base (wall top) at z=0; legs run from -drop up.
module u_handle(span, rise, stock, drop, bend, thick) {
  ztop = rise - stock/2;         // top-bar centreline
  zb   = ztop - bend;            // where the legs stop and the 45s begin
  hx   = span/2;
  pts = [
    [-hx,        -drop],         // left leg bottom (sunk into wall)
    [-hx,         zb   ],        // left leg top
    [-hx + bend,  ztop ],        // left bend -> bar
    [ hx - bend,  ztop ],        // bar -> right bend
    [ hx,         zb   ],        // right leg top
    [ hx,        -drop]          // right leg bottom
  ];
  difference() {
    union() {
      for (i = [0 : len(pts) - 2])
        hull() {
          translate([pts[i][0],   0, pts[i][1]])   cube([stock, thick, stock], center = true);
          translate([pts[i+1][0], 0, pts[i+1][1]]) cube([stock, thick, stock], center = true);
        }
    }
    // ridged "greeble" grip: fine grooves across the TOP bar, along its length
    barL  = 2 * (hx - bend);     // length of the straight top bar (between the 45s)
    ribsp = 2.4;                 // groove pitch
    ribd  = 1.5;                 // groove cutter dia (~0.75 deep)
    nr    = floor(barL / ribsp);
    for (i = [0 : nr])
      translate([-barL/2 + i * (barL / nr), 0, ztop + stock/2])
        rotate([90, 0, 0]) cylinder(d = ribd, h = thick + 2, center = true, $fn = 16);
  }
}

// vertical extrusion of the holder's own outline (rounded profile), used to trim
// any handle material that would stick out past the holder's curved sides.
module footprint_prism(h)
  linear_extrude(height = h) projection() import(STL, convexity = 8);

union() {
  import(STL, convexity = 8);
  intersection() {                       // keep only handle volume within the holder footprint
    union() {
      for (sx = [-1, 1])
        translate([sx * X_OFF, 0, TOP])
          rotate([0, 0, 90])
            u_handle(SPAN, RISE, STOCK, DROP, BEND, THICK);
    }
    translate([0, 0, -1]) footprint_prism(TOP + RISE + 5);
  }
}
