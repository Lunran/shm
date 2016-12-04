include <variables.scad>;
include <cup_base.scad>;

cup_with_pipe();

module cup_with_pipe() {
     difference() {
          union() {
               cup_base();
               pipe_out();
               ditch();
          }
          translate([outer_size/2, outer_size/2+pipe_y-pipe_d-thickness*2, 0]) {
               cylinder(d1=pipe_d, d2=pipe_d, h=pipe_z);
          }
     }
}

module pipe_out() {
     translate([outer_size/2-pipe_x/2, outer_size/2-pipe_x/2, thickness]) difference() {
          cube([pipe_x, pipe_y, pipe_z]);
          translate([pipe_d/2+thickness, pipe_d/2+thickness, 0]) {
               cylinder(d1=pipe_d, d2=pipe_d, h=pipe_z-thickness);
               translate([0, 0, pipe_z-pipe_d/2-thickness]) rotate([-90,0,0]) {
                    cylinder(d1=pipe_d, d2=pipe_d, h=pipe_y-pipe_d-thickness*2);
               }
               translate([-pipe_x/2, 0, 0]) rotate([0, 90, 0]) {
                    cylinder(d1=pipe_d, d2=pipe_d, h=pipe_x);
               }
          }
     }
}

ditch_depth = 10;

module ditch() {
     translate([0, 0, thickness]) difference() {
          cube([outer_size, outer_size, ditch_depth]);
          translate([outer_size/2, outer_size/2, ditch_depth+0.1]) rotate([0, 180, 0]) {
               cylinder(h=ditch_depth, d1=outer_size*sqrt(2), d2=0);
          }
     }
}
