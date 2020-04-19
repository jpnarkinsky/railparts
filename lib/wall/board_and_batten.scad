// print board and batten style siding

module battens(depth, batten_spacing, batten_width, height, count) {
  cube([ batten_width, depth, height ], false);
  if (count>=0) {
    translate([batten_spacing, 0, 0 ]) battens(depth,batten_spacing,batten_width,height,count - 1);
  }
}

module BoardAndBatten(width, depth, height, batten_width, batten_count)
{
    // draw the wall
    translate([0,depth/2,0]) cube([width,depth/2,height], false);

    batten_spacing_x = (width - batten_width) / batten_count;

    translate([0,0,0]) battens(depth/2,batten_spacing_x,batten_width,height,batten_count - 1);
}

board_and_batten(72*12, 1, 10*12, 1, [ 6, 0, 0 ]);
