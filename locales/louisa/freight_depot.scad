use <../../lib/wall/board_and_batten.scad>
use <../../lib/units.scad>
use <../../lib/shapes/open_gable.scad>

module
louisa_freight_depot()
{
    length = 72 * Feet();
    depth = 10 * Feet() + 5.5 * Inches();
    thickness = Inches(2);
    wall_height = Feet(7) + Inches(11);
    roof_height = Feet(11) + Inches(2);
    batten_width = Inches(2.5);

    // walls
    translate([0,0,0]) BoardAndBatten(length, thickness, wall_height, batten_width, 72);
  
    translate([0,depth, 0]) rotate([0,0,-90])  intersection() {
      BoardAndBatten(depth, thickness, roof_height, batten_width, 11); 
      OpenGable(depth, thickness, roof_height, wall_height);
    }
    translate([length,thickness/2,0]) rotate([0,0,90]) intersection() {
      BoardAndBatten(depth, thickness, roof_height, thickness, 11);
      OpenGable(depth, thickness, roof_height, wall_height);
    }
    translate([length,depth,0]) rotate([0,0,180]) BoardAndBatten(length, thickness, wall_height, thickness, 72);

}

louisa_freight_depot();
