use <Console10_bit_holder_handled.scad>
STL="C:/3d files/Gridfinity/1x1x4_sd_card_holder_7.stl";
intersection(){
  difference(){ union(){ import(STL,convexity=8); slot_fill(); } bit_grid(); }
  translate([-1000,0,0]) cube([2000,2000,2000],center=true);   // keep X<0, view X=0 face
}
color("red")    translate([-0.3,0,24]) cube([0.6,60,0.25], center=true);
color("green")  translate([-0.3,0,23]) cube([0.6,60,0.25], center=true);
color("blue")   translate([-0.3,0,22]) cube([0.6,60,0.25], center=true);
