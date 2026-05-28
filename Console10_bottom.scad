// =============================================================================
// CONSOLE10 — Bottom Panel  v3.3  (parametric)
//
// Single-piece floor slab + two side ridges (seat into the cheek bottom-edge
// rabbets). v3.3: 4 counterbored M3 mounting holes per side, from the UNDERSIDE
// up into heat-set inserts in the cheek bottom edges. Prints as one part.
// =============================================================================

panel_width   = 253;     // X, = 10" mini-rack width
panel_depth   = 228.6;   // Y, = module depth (cheek bottom edge)
floor_thick   = 6;       // Z, floor slab thickness
ridge_width   = 10/3;    // tongue width  (equal thirds: tongue = both walls = 10/3)
ridge_height  = 4;       // Z height of ridge above the floor
ridge_inset   = 10/3;    // outer wall = tongue = inner wall = 10/3 (centered, all equal)
ridge_setback = 20;      // Y gap from front edge to start of ridge

// M3 mounting screws (socket-cap, counterbored flush on the underside; up into
// heat-set inserts in the cheek bottom edges)
cheek_thick   = 10;      // matches the cheek (for screw centering)
n_screws      = 4;       // per side
screw_margin  = 20;      // from each end of the bottom edge
m3_clear      = 3.4;     // clearance hole dia
m3_cbore_dia  = 6.0;     // counterbore (socket-cap head) pocket dia
m3_cbore_deep = 3.5;     // counterbore depth (head height + clearance)
cheek_ctr_x   = panel_width/2 - cheek_thick/2;   // 121.5 (cheek centerline)

ridge_len = panel_depth - ridge_setback;   // 208.6

// screw Y positions evenly spaced along the bottom edge (shared with the cheek)
function screw_ys() = [ for (i = [0:n_screws-1])
    screw_margin + i*(panel_depth - 2*screw_margin)/(n_screws-1) ];

echo(str("bottom v3.3  ridge ", ridge_width, "x", ridge_height,
         "   screws/side ", n_screws, " at Y ", screw_ys(), "  X +/-", cheek_ctr_x));

module bottom_panel() {
    difference() {
        union() {
            // floor slab — centered on X, front edge at Y=0
            translate([-panel_width/2, 0, 0])
                cube([panel_width, panel_depth, floor_thick]);
            // left ridge
            translate([-panel_width/2 + ridge_inset, ridge_setback, floor_thick])
                cube([ridge_width, ridge_len, ridge_height]);
            // right ridge
            translate([panel_width/2 - ridge_inset - ridge_width, ridge_setback, floor_thick])
                cube([ridge_width, ridge_len, ridge_height]);
        }
        // M3 holes from the UNDERSIDE (Z=0): clearance up through slab+ridge,
        // counterbore pocket on the Z=0 face (the module floor / world-bottom).
        for (sx = [-cheek_ctr_x, cheek_ctr_x])
            for (sy = screw_ys()) {
                translate([sx, sy, -0.1])
                    cylinder(d = m3_clear, h = floor_thick + ridge_height + 0.2, $fn = 32);
                translate([sx, sy, -0.1])
                    cylinder(d = m3_cbore_dia, h = m3_cbore_deep + 0.1, $fn = 32);
            }
    }
}

bottom_panel();
