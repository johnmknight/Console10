// =============================================================================
// CONSOLE10 — Top Panel  v3.1  (parametric)
//
// Single-piece slab + two side ridges — SAME joinery as the bottom panel.
// In the module the top is flipped so the ridges point DOWN into rabbets in
// the cheek top edges. Width = 10" mini-rack standard, prints as one part.
// =============================================================================

panel_width   = 253;       // X, = 10" mini-rack width
panel_depth   = 109.975;   // Y, = cheek top-edge length
slab_thick    = 6;         // Z, slab thickness
ridge_width   = 4;         // X width of each side ridge
ridge_height  = 4;         // Z height of ridge above the slab
ridge_inset   = 4;         // X gap from panel side edge to ridge outer face
ridge_setback = 0;         // Y gap from the panel end to the start of the ridge

ridge_len = panel_depth - ridge_setback;

echo(str("top  ", panel_width, " x ", panel_depth, " x ", slab_thick + ridge_height,
         " mm   ridge ", ridge_width, "x", ridge_height, " len ", ridge_len));

module top_panel() {
    // slab — centered on X
    translate([-panel_width/2, 0, 0])
        cube([panel_width, panel_depth, slab_thick]);

    // left ridge
    translate([-panel_width/2 + ridge_inset, ridge_setback, slab_thick])
        cube([ridge_width, ridge_len, ridge_height]);

    // right ridge
    translate([panel_width/2 - ridge_inset - ridge_width, ridge_setback, slab_thick])
        cube([ridge_width, ridge_len, ridge_height]);
}

top_panel();
