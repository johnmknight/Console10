intersection() {
  import("C:/3d files/Gridfinity/1x1x4_sd_card_holder_7.stl", convexity=12);
  translate([-1000,0,0]) cube([2000,2000,2000], center=true);
}
// reference plates at known Z (red=26, green=24, blue=22, yellow=20)
color("red")    translate([-0.3,0,26]) cube([0.6,60,0.3], center=true);
color("green")  translate([-0.3,0,24]) cube([0.6,60,0.3], center=true);
color("blue")   translate([-0.3,0,22]) cube([0.6,60,0.3], center=true);
color("yellow") translate([-0.3,0,20]) cube([0.6,60,0.3], center=true);
