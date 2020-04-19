/* Test code for an example iBeam */

iBeam(webThickness=2, height=5*12, length=12*40, thickness=2, width=12);

/**
 * @param {Object} params - parameters
 * @param {number} params.webThickness - web thickness
 * @param {number} params.height - beam height
 * @param {number} params.length - beam length
 * @param {number} params.thickness - flange thickness
 * @param {number} params.width - flang width
 */
module iBeam( height, length, thickness, webThickness, width ) {
  linear_extrude(height=length) union() {
    square( [width, thickness] );
    translate([(width - thickness)/2,0]) square( [webThickness, height ]);
    translate([0, height - thickness]) square( [width, thickness] );
  }
}

