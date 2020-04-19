module OpenGable(width, depth, height, eaves_height) {
  translate([0,depth,0]) rotate([90,0,0]) linear_extrude(height=depth) 
    polygon(points=[[0,0], [0,eaves_height], [width/2, height], [width, eaves_height], [width,0], [0,0]]);
}
