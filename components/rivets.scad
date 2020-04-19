// Test code
rivet(10,1);
rivetRow(240, 24, 10, 1.5);

// create a single rivet head
module rivet( length, rivetSize ) {
  union() {
    translate([0,0, rivetSize]) sphere(r=rivetSize, $fn=12);
    translate([0,0, length - rivetSize]) sphere(r=rivetSize, $fn=12);
  }
  //cylinder(r = rivetSize, h = length, $fn=12 );
}

// create a row of rivets
//
// @param {Object} params - parameters
// @param {number} params.spacing - rivet spacing
// @param {number} params.length - length of rivet row
// @param {number} params.thickness - length of rivets
// @returns {Object} row of rivets
module rivetRow( length, spacing, rivetLength, rivetSize = 1 ) {
    for (i = [0 : length/spacing - 1])  
      {   
        translate([0, 0, (spacing / 2) + (i * spacing)]) 
          rotate([90,0,0]) 
            rivet(length = rivetLength, 
            rivetSize = rivetSize );
      }
}
