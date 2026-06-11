// Console10 — 4mm hex precision-bit holder + grab handles (one part)
// ----------------------------------------------------------------------------
// Built from the SAME Gridfinity bin as the SD holder (import keeps the standard
// stacking BASE and the recessed top TRAY untouched). Only the SD slots in the
// tray floor are filled, then a 5 x 4 grid of 4mm-hex bit pockets is drilled into
// that floor. Recess + rim + base preserved.
// ----------------------------------------------------------------------------

STL    = "C:/3d files/Gridfinity/1x1x4_sd_card_holder_7.stl";
HALF   = 20.75;   // bin half-width (STL spans -20.75..20.75)
TOP    = 26.8;    // rim top Z (STL max)
FLOOR  = 23.6;    // recessed tray floor surface (slot tops) — fill slots flush to here

// ---- slot fill: solidify the WHOLE tray floor (covers slots + their sub-recess
//      frame; reaches the recess walls so there's no seam) ----
FILL_W = 36; FILL_L = 36; FILL_R = 3;
FILL_Z0 = 2;                             // SD slots run from the floor down INTO the base region, so
                                         // fill to Z=2 to cover their FULL depth. Verified the base
                                         // underside (flat base + 4 corner holes + lip) is identical
                                         // at FILL_Z0 2 vs 4.75, so this doesn't touch the base.
                                         // (Was 18 -> only the slot tops were filled, leaving the
                                         // lower SD slots as vestigial voids in the interior.)

// ---- bit grid (validated: 4mm hex bit, 0.20 mm/side) ----
NX     = 4;       // holes ACROSS X
NY     = 5;       // holes DEEP along Y
HEX_AF = 4.0;     // hex across-flats
HEX_CLR= 0.20;
HEX_D  = (HEX_AF + 2*HEX_CLR) / cos(30);
HOLE_DP= 11;      // pocket depth below the tray floor
PITCH  = 6.6;

STOCK  = 3; THICK = STOCK + 1; RISE = 10; SPAN = 2*HALF - STOCK; DROP = 16; BEND = 4;
X_OFF  = HALF - THICK/2;

module rr(w,l,r) hull() for (sx=[-1,1], sy=[-1,1]) translate([sx*(w/2-r), sy*(l/2-r)]) circle(r=r, $fn=48);

// U-handle: two 45-deg bends, ridged grip on the top bar.
module u_handle(span, rise, stock, drop, bend, thick) {
  ztop = rise - stock/2; zb = ztop - bend; hx = span/2;
  pts = [[-hx,-drop],[-hx,zb],[-hx+bend,ztop],[hx-bend,ztop],[hx,zb],[hx,-drop]];
  difference() {
    union() {
      for (i = [0 : len(pts)-2]) hull() {
        translate([pts[i][0],0,pts[i][1]])   cube([stock,thick,stock], center=true);
        translate([pts[i+1][0],0,pts[i+1][1]]) cube([stock,thick,stock], center=true);
      }
    }
    barL = 2*(hx-bend); ribsp = 2.4; ribd = 1.5; nr = floor(barL/ribsp);
    for (i = [0:nr]) translate([-barL/2 + i*(barL/nr), 0, ztop+stock/2])
      rotate([90,0,0]) cylinder(d=ribd, h=thick+2, center=true, $fn=16);
  }
}

module footprint_prism(h) linear_extrude(height=h) projection() import(STL, convexity=8);  // for handle trim
module slot_fill()  translate([0,0,FILL_Z0]) linear_extrude(FLOOR-FILL_Z0) rr(FILL_W, FILL_L, FILL_R);
module bit_grid()
  for (ix=[0:NX-1], iy=[0:NY-1])
    translate([(ix-(NX-1)/2)*PITCH, (iy-(NY-1)/2)*PITCH, FLOOR-HOLE_DP])
      rotate([0,0,30]) cylinder(d=HEX_D, h=HOLE_DP+0.5, $fn=6);

module bit_holder() {
  union() {
    difference() {
      union() {
        import(STL, convexity=8);   // Gridfinity base + body + recessed tray
        slot_fill();                // fill the SD slots flush to the tray floor
      }
      bit_grid();                   // drill the hex pockets into the floor
    }
    intersection() {                // handles, trimmed to the bin footprint
      union() {
        for (sx=[-1,1]) translate([sx*X_OFF,0,TOP]) rotate([0,0,90]) u_handle(SPAN,RISE,STOCK,DROP,BEND,THICK);
      }
      translate([0,0,-1]) footprint_prism(TOP+RISE+5);
    }
  }
}

// SECTION=1 (via -D) renders a cut-away for diagnostics; default draws the full part.
SECTION = false;
if (SECTION) difference() { bit_holder(); translate([0,0,-5]) cube([60,60,60]); }
else bit_holder();
