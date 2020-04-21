use <../../lib/shapes/open_gable.scad>
use <../../lib/units.scad>
use <../../lib/wall/board_and_batten.scad>
use <../../lib/window/double_sash_window.scad>

module
LouisaFreightDepot()
{
    length = 72 * Feet();
    depth = 220 * Inches();
    thickness = Inches(2);
    wall_height = Feet(7) + Inches(11);
    roof_height = Feet(11) + Inches(2);
    batten_width = Inches(2.5);

    // walls
    translate([ 0, 0, 0 ]) BoardAndBatten(
        length, thickness, wall_height, batten_width, batten_count = 72);

    // west wall
    translate([ 0, depth, 0 ]) rotate([ 0, 0, -90 ]) intersection()
    {
        BoardAndBatten(depth, thickness, roof_height, batten_width, 11);
        OpenGable(depth, thickness, roof_height, wall_height);
    }

    // east wall
    translate([ length, thickness / 2, 0 ]) rotate([ 0, 0, 90 ]) union()
    {
        difference()
        {
            intersection()
            {
                BoardAndBatten(depth,
                               thickness,
                               roof_height,
                               thickness,
                               batten_count = 20);
                OpenGable(depth, thickness, roof_height, wall_height);
            };
            translate([ Inches(90.5), Inches(-3), Inches(20) ]) 
                cube([ Inches(47), Inches(12), 76 * Inches()], false);
            
        }

        translate([ Inches(90.5), Inches(6), Inches(20) ])
          rotate([90,0,0]) 
                    DoubleSashWindow(width = 47 * Inches(),
                             height = 76 * Inches(),
                             depth = 6 * Inches(),
                             casing_width = 5.75 * Inches(),
                             casing_thickness = 1 * Inches(),
                             casing_bottom = 2 * Inches(),
                             pane_cols = 3,
                             pane_rows = 3);
    }

    // SOUTH
    translate([ length, depth, 0 ]) rotate([ 0, 0, 180 ])
        BoardAndBatten(length, thickness, wall_height, thickness, 72);}LouisaFreightDepot();
