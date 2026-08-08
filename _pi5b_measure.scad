// Measurement aid — overlay axes on the rotated bracket
include <pi5bracket_edit.scad>

// Origin marker (red)
color("red") sphere(d = 3);
// +X axis (red), 60 mm
color("red")   translate([30, 0, 0]) cube([60, 1, 1], center = true);
// +Y axis (green), 60 mm (forward toward viewer in OpenSCAD Front view)
color("green") translate([0, 30, 0]) cube([1, 60, 1], center = true);
// +Z axis (blue), 60 mm (up)
color("blue")  translate([0, 0, 30]) cube([1, 1, 60], center = true);

// 10 mm tick marks on each axis
for (i = [10, 20, 30, 40, 50]) {
    color("red")   translate([i,   0, 0]) cube([0.5, 4, 0.5], center = true);
    color("green") translate([0,   i, 0]) cube([4, 0.5, 0.5], center = true);
    color("blue")  translate([0,   0, i]) cube([4, 0.5, 0.5], center = true);
}
