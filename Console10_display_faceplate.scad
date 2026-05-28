// =============================================================================
// CONSOLE10 — Display Faceplate  v0.2  (parametric, RECESSED / flush mount)
//
// For the ELECROW RC070 7" 1024x600 IPS touch (Amazon B08FMNDDSL), Pi-on-back.
// The screen drops in from BEHIND into a pocket; its glass sits ~flush with the
// faceplate front, retained by a front lip. Ports are on the RIGHT edge.
//
//   KNOWN  (Elecrow): active area 164.7 x 107.1 mm, ports right, Pi on back.
//   MEASURE ON ARRIVAL (Elecrow doesn't publish these): board outer W/H,
//   front-frame depth, corner-hole spacing. They're flagged below — drop in
//   caliper values and it's done.
// =============================================================================

// ---- rack faceplate ----
U        = 44.45;
n_u      = 3;            // 3U
plate_w  = 253;          // 10" mini-rack width
plate_t  = 6;            // thicker, to give a recess step
plate_h  = n_u * U;      // 133.35

// ---- display window (KNOWN: active area) ----
lcd_w    = 164.7;        // active width  (the visible window)
lcd_h    = 107.1;        // active height
win_gap  = 0.5;          // window oversize per side

// ---- recess pocket (MEASURE board outline + frame depth) ----
board_w  = 173;          // ESTIMATE board outer width   <-- MEASURE
board_h  = 124;          // ESTIMATE board outer height  <-- MEASURE
board_clr   = 0.5;       // pocket clearance per side
front_frame = 4;         // ESTIMATE bezel front-frame depth (sets flush) <-- MEASURE

pocket_w = board_w + 2*board_clr;
pocket_h = board_h + 2*board_clr;
lip_t    = plate_t - front_frame;   // front lip that retains the glass

// ---- right-side port relief (ports on the right facing edge) ----
port_relief_h = 70;      // height of the relief along the right pocket wall
port_relief_d = 6;       // extra outward clearance for connectors/cables

// ---- rack mount screws (2/side, into cheek slant inserts) ----
rail_dx = 236.525;       // ALIGN to slant inserts
rack_clr = 5.5;          // 10-32 clearance
eia = [6.35, 22.225, 38.10];

$fn = 48;
cx = 0; cy = plate_h/2;

module faceplate() {
    difference() {
        translate([-plate_w/2, 0, 0]) cube([plate_w, plate_h, plate_t]);

        // front window = active area (through the lip)
        translate([cx, cy, plate_t/2])
            cube([lcd_w + 2*win_gap, lcd_h + 2*win_gap, plate_t + 2], center = true);

        // recess pocket from the BACK (display drops in here)
        translate([cx, cy, plate_t - front_frame + 50])   // 50 = arbitrary > depth; cube extends back
            cube([pocket_w, pocket_h, 100], center = true);

        // right-side port relief (extends the pocket outward on +X for the connectors)
        translate([cx + pocket_w/2, cy, plate_t - front_frame + 50])
            cube([port_relief_d*2, port_relief_h, 100], center = true);

        // rack mount screws — 2 per side (bottom + top)
        rack_ys = [ eia[0], (n_u - 1)*U + eia[2] ];
        for (sx = [-rail_dx/2, rail_dx/2])
            for (y = rack_ys)
                translate([sx, y, -1]) cylinder(d = rack_clr, h = plate_t + 2);
    }
}

echo(str("faceplate ", plate_w, "x", plate_h, " (", n_u, "U) t", plate_t,
         " | window ", lcd_w, "x", lcd_h, " | pocket ", pocket_w, "x", pocket_h,
         " | lip ", lip_t, " mm"));

faceplate();
