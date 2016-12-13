include <variables.scad>;
include <cup_base.scad>;

cup_with_pipe();

module cup_with_pipe() {
     difference() {
          union() {
               shell();
               ditch();
               holders();
          }
          hole();
          upper_holes();
          lower_holes();
     }
     pipe_out();
}

pipe_gap = pipe_y - pipe_d - thickness*2;
pipe_length = pipe_z - pipe_gap/2 -pipe_d/2 - thickness;

module pipe_out() {
     translate([outer_size/2-pipe_x/2, outer_size/2-pipe_x/2, thickness]) difference() {
          cube([pipe_x, pipe_y, pipe_z]);
          translate([pipe_d/2+thickness, pipe_d/2+thickness, 0]) {
               cylinder(d1=pipe_d, d2=pipe_d, h=pipe_length);
               translate([0, pipe_gap, 0]) cylinder(d1=pipe_d, d2=pipe_d, h=pipe_length);
               translate([0, pipe_gap/2, pipe_length]) rotate([0, 90, 0]) {
                    difference() {
                         rotate_extrude() translate([pipe_gap/2, 0, 0]) circle(d=pipe_d);
                         translate([0, -pipe_y/2, -pipe_d/2]) cube([pipe_y/2, pipe_y, pipe_d]);
                    }
               }
               translate([-pipe_x/2, 0, 0]) rotate([0, 90, 0]) {
                    cylinder(d1=pipe_d+2, d2=pipe_d+2, h=pipe_x);
               }
          }
     }
}
