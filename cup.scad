include <variables.scad>;
include <cup_base.scad>;

cup();

module cup() {
     difference() {
          union() {
               shell();
               holders();
          }
          upper_holes();
     }
}
