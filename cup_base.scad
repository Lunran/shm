include <variables.scad>;

module shell() {
     difference() {
          cube(outer_size);
          translate([thickness,thickness,thickness]) {
               cube([outer_size-thickness*2, outer_size-thickness*2, outer_size-thickness]);
          }
     }
}

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
          for(angle=[0:90:359]) rotate(angle) {
               translate([outer_size/2-holder_size, outer_size/2-holder_size, 0]) holder();
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

module hole() {
     translate([outer_size/2, outer_size/2+pipe_y-pipe_d-thickness*2, 0]) {
          cylinder(d1=pipe_d, d2=pipe_d, h=thickness+ditch_depth);
     }
}

string_d = 5;
string_R = 10;
string_offset = string_d/2 + thickness;

module string_hole() {
     intersection() {
          translate([0, 0, -string_d/2]) cube([string_R+string_d, string_R+string_d, string_d]);
          rotate_extrude() translate([string_R, 0, 0]) circle(d=string_d);
     }
}

module string_holes() {
     translate([outer_size/2, outer_size/2, 0]) for(angle = [0:90:359]) rotate(angle) {
               translate([outer_size/2, outer_size/2, 0]) rotate(180) string_hole();
     }
}

module upper_holes() {
     translate([0, 0, outer_size - string_offset]) {
          string_holes();
     }
}

module lower_holes() {
     translate([0, 0, string_offset]) {
          string_holes();
     }
}
