// Console10 — 4mm hex-bit pocket FIT-TEST coupon
// ----------------------------------------------------------------------------
// Four hex pockets at different per-side clearances, at the real 11 mm depth, so
// you can drop a 4mm hex bit into each and pick the best fit. The clearance (x100)
// is embossed next to each pocket. Set HEX_CLR in Console10_bit_holder_handled.scad
// to the winner (e.g. pocket labelled "20" -> HEX_CLR = 0.20).
// ----------------------------------------------------------------------------

HEX_AF = 4.0;                       // 4mm hex bit across-flats
DEPTH  = 11;                        // real pocket depth
CLRS   = [0.10, 0.20, 0.30, 0.40];  // per-side clearance variants to try

pitch  = 12;
floor_t= 2.5;
bar_h  = DEPTH + floor_t;
bar_w  = 16;
n      = len(CLRS);
bar_l  = n*pitch + 6;

module hex_pocket(clr)
  rotate([0,0,30]) cylinder(d = (HEX_AF + 2*clr)/cos(30), h = DEPTH + 1, $fn = 6);

difference() {
  union() {
    translate([0, 0, bar_h/2]) cube([bar_l, bar_w, bar_h], center = true);
    // raised labels (clearance x100) along the front edge
    for (i = [0:n-1])
      translate([(i-(n-1)/2)*pitch, -bar_w/2 + 1, bar_h])
        linear_extrude(0.6) text(str(round(CLRS[i]*100)), size = 4.5, halign = "center", valign = "bottom");
  }
  // the hex pockets, drilled from the top
  for (i = [0:n-1])
    translate([(i-(n-1)/2)*pitch, 2.5, bar_h - DEPTH]) hex_pocket(CLRS[i]);
}
