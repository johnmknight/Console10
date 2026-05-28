// =============================================================================
// CONSOLE10 — Top Panel  v3.3  (parametric)
//
// Single-piece slab + two side ridges (same joinery as the bottom). Flipped in
// the module so ridges point DOWN into the cheek top rabbets.
//   - front edge beveled to the slant angle (hull-built)
//   - v3.3: 3 counterbored (flush socket-cap) M3 mounting holes per side,
//     centered over each cheek, screwing down into heat-set inserts in the
//     cheek top edge.
// NOTE: standalone the bevel/countersinks read "upside down" (slab top face is
// world-bottom pre-flip) — judge it in Console10_module.scad.
// =============================================================================

panel_width   = 253;       // X, = 10" mini-rack width
panel_depth   = 109.975;   // Y, = cheek top-edge length
slab_thick    = 6;         // Z, slab thickness
ridge_width   = 10/3;      // tongue width  (equal thirds: tongue = both walls = 10/3)
ridge_height  = 4;         // Z height of ridge above the slab
ridge_inset   = 10/3;      // outer wall = tongue = inner wall = 10/3 (centered, all equal)
ridge_setback = 0;         // Y gap from the panel end to the start of the ridge

front_bevel   = true;      // bevel the front edge to match the slant
slant_angle   = 30;        // deg from vertical
bevel         = front_bevel ? slab_thick * tan(slant_angle) : 0;   // 3.46 mm

// M3 mounting screws (socket-cap, COUNTERBORED flush; down through the top into
// heat-set inserts in the cheek tops)
cheek_thick   = 10;        // matches the cheek (for screw centering)
n_screws      = 3;         // per side
screw_margin  = 15;        // from each end of the top edge
m3_clear      = 3.4;       // clearance hole dia
m3_cbore_dia  = 6.0;       // counterbore (socket-cap head) pocket dia
m3_cbore_deep = 3.5;       // counterbore depth (head height + clearance)
cheek_ctr_x   = panel_width/2 - cheek_thick/2;   // 121.5 (cheek centerline)

ridge_len = panel_depth - ridge_setback;
eps = 0.01;

// screw Y positions evenly spaced along the top edge (shared with the cheek)
function screw_ys() = [ for (i = [0:n_screws-1])
    screw_margin + i*(panel_depth - 2*screw_margin)/(n_screws-1) ];

echo(str("top v3.3  bevel ", bevel, " mm   screws/side ", n_screws,
         " at Y ", screw_ys(), "  X +/-", cheek_ctr_x));

module top_panel() {
    difference() {
        union() {
            // beveled slab: hull between bottom face (front set back) and top face (flush)
            hull() {
                translate([-panel_width/2, bevel, 0])
                    cube([panel_width, panel_depth - bevel, eps]);
                translate([-panel_width/2, 0, slab_thick - eps])
                    cube([panel_width, panel_depth, eps]);
            }
            // side ridges (on the +Z face)
            translate([-panel_width/2 + ridge_inset, ridge_setback, slab_thick])
                cube([ridge_width, ridge_len, ridge_height]);
            translate([panel_width/2 - ridge_inset - ridge_width, ridge_setback, slab_thick])
                cube([ridge_width, ridge_len, ridge_height]);
        }
        // M3 holes — clearance through slab+ridge + a counterbore pocket on the
        // Z=0 face (becomes the world-top surface after the module's mirror), so
        // the socket-cap head sits flush/recessed.
        for (sx = [-cheek_ctr_x, cheek_ctr_x])
            for (sy = screw_ys()) {
                translate([sx, sy, -0.1])
                    cylinder(d = m3_clear, h = slab_thick + ridge_height + 0.2, $fn = 32);
                translate([sx, sy, -0.1])
                    cylinder(d = m3_cbore_dia, h = m3_cbore_deep + 0.1, $fn = 32);
            }
    }
}

top_panel();
