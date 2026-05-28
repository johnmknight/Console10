// =============================================================================
// CONSOLE10 — Front Insert  v3.0  (parametric remodel of NASA_Insert_Front.stl)
//
// Triangular-prism wedge that sits ON TOP of the bottom panel, at the FRONT,
// spanning BETWEEN the cheeks. 30 deg face (matches the front slant). Print
// standalone and glue, or merge into the bottom part.
//
// (Original STL face was ~28.5 deg; this uses the design-correct 30 deg.)
// =============================================================================

panel_width  = 253;       // 10" mini-rack width (= bottom/top width)
cheek_thick  = 10;        // cheek thickness
span_clear   = 0.4;       // total fit clearance between the cheeks
span_width   = panel_width - 2*cheek_thick - span_clear;   // ~232.6 (fits between cheeks)

wedge_height = 38;        // vertical leg, mm
wedge_angle  = 30;        // face angle from vertical, deg
wedge_depth  = wedge_height * tan(wedge_angle);            // 21.94 at 30 deg

echo(str("front insert  span(X)=", span_width, "  depth(Y)=", wedge_depth,
         "  height(Z)=", wedge_height, "  angle=", wedge_angle));

// Cross-section in X-Z (depth x height); extruded along the span.
module front_insert() {
    rotate([90, 0, 0])
        linear_extrude(height = span_width)
            polygon([[0, 0], [wedge_depth, 0], [0, wedge_height]]);
}

front_insert();
