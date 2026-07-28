// =============================================================================
// pi5bracket — modification wrapper
//
// Imports the STL mesh and lets us add or subtract features via boolean ops.
// Source STL bounding box: 82.95 W x 82.95 D x 88 H mm, anchored at
// X=[44.8, 127.8], Y=[63.2, 146.1], Z=[0, 88]. We re-center to (0, 0, 0) at the
// X/Y midpoint and Z=0 baseline so modifications are easier to position.
//
// ADD a feature:    union()      { pi5bracket(); <new geometry>; }
// REMOVE a feature: difference() { pi5bracket(); <hole shape>; }
// =============================================================================

$fn = 64;

module pi5bracket() {
    // Port face of the STL is on +Z (top). Rotate so it lands on +Y (the face
    // visible in OpenSCAD's "Front" view), then re-center the result so the
    // port face sits at Y=0 and the bracket depth extends in -Y. X is centered
    // around 0, Z is centered around 0 (bracket height).
    translate([0, 0, 0])
        rotate([-90, 0, 0])
            translate([-(44.80404 + 127.7574)/2,    // center X
                       -(63.18881 + 146.1421)/2,   // center old-Y (now -Z)
                       -88])                       // shift port face from Z=88 to Z=0 -> after rotate, Y=0
                import("pi5bracket.stl", convexity = 10);
}

// =============================================================================
// EDIT BELOW — add union()/difference() wrappers as needed.
// Default: render the unmodified bracket so the editor shows the source mesh.
// =============================================================================
pi5bracket();

// Example: drill a 5 mm hole through the bracket along Z, centered at origin
// difference() {
//     pi5bracket();
//     translate([0, 0, -1]) cylinder(d = 5, h = 90);
// }
