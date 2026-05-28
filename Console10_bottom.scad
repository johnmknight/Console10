// =============================================================================
// CONSOLE10 — Bottom Panel  v3.0  (parametric remodel of new_nasa_bottom.stl)
//
// Single-piece floor slab + two side ridges that seat into the cheek
// bottom-edge rabbets. Width = 10" mini-rack standard, prints as one part.
// =============================================================================

panel_width   = 253;     // X, = 10" mini-rack width
panel_depth   = 228.6;   // Y, = module depth (cheek bottom edge)
floor_thick   = 6;       // Z, floor slab thickness
ridge_width   = 4;       // X width of each side ridge
ridge_height  = 4;       // Z height of ridge above the floor
ridge_inset   = 4;       // X gap from panel side edge to ridge outer face
ridge_setback = 20;      // Y gap from front edge to start of ridge

ridge_len = panel_depth - ridge_setback;   // 208.6

echo(str("bottom  ", panel_width, " x ", panel_depth, " x ", floor_thick + ridge_height,
         " mm   ridge ", ridge_width, "x", ridge_height, " len ", ridge_len));

module bottom_panel() {
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

bottom_panel();
