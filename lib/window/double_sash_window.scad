use <sash.scad>

module DoubleSashWindow(
  // These parameters are required
  width,  // The total outside width of the window (including the casing.)
  height, // the total outside height of the window (including the apron and head)
  depth, // The total depth of the window, NOT including the casing the jamb
  casing_width, // the width of the casing, will also be default value for footer and apron
  casing_thickness, // the thickness of the casing, will also be default value for footer and apron
  
  // these have default values
  pane_rows=2,
  pane_cols=2,

  // These will be calculated from other parameters if they are not specified.
  head_width, // the width of the head board
  grill_width, // the width of each grill
  rail_width, // the width of the sash
  sash_thickness, // the thickness of the sash
  stool_depth, // total thickness of the stool (will protrude from front)
  apron_width, // the width of the apron
  rail_width, // the width of the rail
  jamb_thickness, // 
  casing_bottom,
) {
  assert(width, "Must provide a window width");
  assert(depth, "Must provide a window depth");
  assert(height, "Must provide a window height");
  assert(casing_width, "Must provide a casing width");
  assert(casing_thickness, "Must provide a casing thickness");

  if (!head_width) {
    head_width = casing_width;
  }

  rw = rail_width ? rail_width : casing_width/2;
  gw = grill_width ? grill_width : rw/2;
  st = sash_thickness ? sash_thickness : depth/3;
  cb = casing_bottom ? casing_bottom : casing_width;

  if (!stool_depth) {
    stool_depth = 1.1 * depth;
  }

  if (!apron_width) {
    apron_width = casing_width;
  }

  jamb_width = casing_width;
  inner_height = height - 2 * jamb_width;
  inner_width = width - 2 * jamb_width;

  rotate([90,0,90]) union() {
    // draw the casing
    difference() {
      translate([0,0,-casing_thickness]) cube([width,height,depth + 2 * casing_thickness], false);
      translate([jamb_width,jamb_width,-1]) 
        cube([inner_width, inner_height, depth+2], false);
    };

    // Draw the upper sash
    translate([jamb_width,jamb_width + inner_height/2,st*1.5]) Sash(
      width=inner_width, 
      height=inner_height/2 + st, 
      depth=st, 
      rail_width=rw,
      grill_width=gw,
      pane_cols=pane_cols,
      pane_rows=pane_rows
    );

    // draw the lower sash
    translate([jamb_width,jamb_width,st/2]) Sash(
      width=inner_width, 
      height=inner_height/2 + st, 
      depth=st, 
      rail_width=rw,
      grill_width=gw,
      pane_cols=pane_cols,
      pane_rows=pane_rows
    );
  }
}

DoubleSashWindow(
  width=48,
  height=96,
  depth=6,
  casing_width=4,
  casing_thickness=.75,
  pane_cols=3,
  pane_rows=3);
