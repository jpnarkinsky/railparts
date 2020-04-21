module grill(offset, size, count) {
  if (count > 1) {
    translate(offset) cube(size, true);
    translate(offset) grill(offset, size, count - 1);
  }
} 

module Sash(
  // These parameters are required
  width,  // The total outside width of the window (including the casing.)
  height, // the total outside height of the window (including the apron and head)
  depth, // The total depth of the window, including the jamb
  rail_width, //the height of the top and bottom rail(s)
  grill_width, // the width of the grill
  pane_cols, // how many panes (horizontal)
  pane_rows, // how many panes (vertical)
) {
  assert(width, "Must provide a window width");
  assert(height, "Must provide a window height");
  assert(depth, "Must provide a window depth");
  assert(rail_width, "Must provide a rail width");
  assert(grill_width, "Must provide a grill width");
  assert(pane_cols, "Must provide the number of pane cols");
  assert(pane_rows, "must provide the number of pane rows");

  inner_width=(width-2*rail_width);
  inner_height=(height-2*rail_width);

  union() {
    difference() {
      cube([width,height,depth], false);
      translate([rail_width,rail_width,-1]) cube([inner_width, inner_height, depth+2], false);
    };

    // draw vertical sashes
    translate([rail_width, inner_height/2 + rail_width, depth/2]) grill(
      offset=[inner_width/pane_cols, 0, 0],
      size=[grill_width, inner_height, grill_width], 
      count=pane_cols
    );

    // draw horizontal sashes
    translate([inner_width/2 + rail_width, rail_width, depth/2]) grill(
      offset=[0, inner_height/pane_rows, 0],
      size=[inner_width, grill_width, grill_width], 
      count=pane_rows
    );
  }
}

Sash(width=24,height=36,depth=4,rail_width=2,grill_width=1,pane_cols=3,pane_rows=3);
