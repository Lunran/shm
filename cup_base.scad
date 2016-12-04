include <variables.scad>;

cup_base();

module cup_base() {
     difference() {
          // make a hole on cup_base because openscad seems not to be able to substract an object
          // from an included object
          shell();
          translate([outer_size/2, outer_size/2+pipe_y-pipe_d-thickness*2, 0]) {
               cylinder(d1=pipe_d, d2=pipe_d, h=thickness);
          }
     }
     holders();
}

module shell() {
     difference() {
          cube(outer_size);
          translate([thickness,thickness,thickness])
               cube([outer_size-thickness*2, outer_size-thickness*2, outer_size-thickness]);
     }
}

holder_size = 28;
holder_inner_size = holder_size - thickness*2;
points = [[0,0,0], [holder_size,0,0], [0,holder_size,0], [0,0,holder_size]];
faces = [[0,1,2], [0,3,1], [0,2,3], [1,3,2]];

module holder() {
     difference() {
          cube([holder_size, holder_size, holder_size]);
          translate([thickness, thickness, 0]) {
               cube([holder_inner_size, holder_inner_size, holder_size]);
          }
          polyhedron(points, faces);
     }
}

module holders() {
     translate([outer_size/2, outer_size/2, outer_size-holder_size]) {
          for(angle=[0:90:359]) {
               rotate(angle) {
                    translate([outer_size/2-holder_size, outer_size/2-holder_size, 0]) {
                         holder();
                    }
               }
          }
     }
}
