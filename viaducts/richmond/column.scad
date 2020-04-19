use <../../components/rivets.scad>
use <../../components/ubeam.scad>
use <../../components/ibeam.scad>

/**
 * 
 * @param {Object} params 
 * @param {number} params.d - column depth
 * @param {number} params.l - column length
 * @param {number} params.t - material thickness
 * @param {number} params.w - column width 
 * @param {number} params.spacing - rivet spacing
 */
module column(depth, width, length, thickness,  rivetSpacing, rivetSize) {
  union() {
    translate([width / 4, 3*thickness, 0])
      rivetRow(length=length, spacing=rivetSpacing, rivetLength=thickness * 4);
    translate([3 * width / 4, depth / 4, 0])
      rivetRow(length=length, spacing=rivetSpacing, rivetLength=thickness * 4); 
    translate([width / 4, depth + 3 * thickness, 0])
       rivetRow(length=length, spacing=rivetSpacing, rivetLength=thickness * 4);
    translate([3 * width / 4, depth + 3 * thickness, 0])
       rivetRow(length=length, spacing=rivetSpacing, rivetLength=thickness * 4);

    // translate([width - thickness, width / 4, 0])
    //   rivetRow( length=length, spacing = rivetSpacing, thickness = thickness * 4 );
    // translate([thickness, depth + width / 4, 0])
    //   rivetRow( length=length, spacing = rivetSpacing, thickness = thickness * 4 );
    // translate([width - thickness, depth + wdith / 4, 0])
    //   rivetRow( length=length, spacing = rivetSpacing, rivetLength = thickness * 4 );
    translate([0, thickness, 0]) 
      rotate([0,0,-90]) 
      uBeam(width = width, height = depth/3, thickness=thickness, length=length); 
    translate([width, depth + thickness, 0]) 
      rotate([0,0,90]) 
      uBeam(width = width, height = depth/3, thickness=thickness, length=length); 
    translate([0, thickness, 0])    
      iBeam(
        thickness=thickness, 
        width=depth, 
        webThickness=thickness, 
        height=depth, 
        length=length
      );
  }   
}

column(12,12, 240, 1, 6, 1.5);
