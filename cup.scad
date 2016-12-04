include <variables.scad>;
include <cup_base.scad>;

cup();

module cup() {
     // make a hole on cup_base because openscad seems not to be able to substract an object
     // from an included object
     cup_base();
     translate([outer_size/2, outer_size/2+pipe_y-pipe_d-thickness*2, 0]) {
          cylinder(d1=pipe_d, d2=pipe_d, h=thickness);
     }
}
