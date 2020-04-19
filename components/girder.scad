use <ibeam.scad>
use <rivets.scad>

/**
 * @param {Object} params - parameters
 * @param {number} params.webThickness - web thickness
 * @param {number} params.height - beam height
 * @param {number} params.length - beam length
 * @param {number} params.thickness - flange thickness
 * @param {number} params.width - flang width
 * @param {number} params.ribCount - number of ribs
 */
module girder(width,
              thickness,
              webThickness,
              height,
              length,
              ribCount,
              rivetSpacing = 0,
              rivetSize = 1.5)
{
    union()
    {
        for (i = [0:ribCount]) {
            union()
            {
                rotate([ 0, 0, 90 ])
                    translate([ 0, -width, i * length / ribCount ])
                        cube([ height, width, thickness ]);
                if (rivetSpacing > 0)
                    translate([
                        (width - thickness) / 4,
                        height,
                        (i * length / ribCount) + 2 *
                        thickness
                    ]) rotate([ 90, 0, 0 ])
                        rivetRow(spacing = height,
                                 length = height,
                                 rivetLength = 3 * thickness);
                // if (rivetSpacing > 0)
                //     translate([
                //         width - (width - thickness) / 4,
                //         height,
                //         (i * length / ribCount) + 2 *
                //         thickness
                //     ]) rotate([ 90, 0, 0 ])
                //         rivetRow(spacing = rivetSpacing * 4,
                //                  length = height,
                //                  rivetLength = thickness * 3);
            }
        };
        iBeam(webThickness = webThickness,
              height = height,
              length = length,
              thickness = thickness,
              width = width);
        if (rivetSpacing > 0)
            translate([ (width - thickness) / 4, 2 * thickness, 0 ])
                rivetRow(length = length,
                         rivetLength = 3 * thickness,
                         spacing = rivetSpacing,
                         rivetSize = rivetSize);
        if (rivetSpacing > 0)
            translate([ width - (width - thickness) / 4, 2 * thickness, 0 ])
                rivetRow(length = length,
                         rivetLength = 3*thickness,
                         spacing = rivetSpacing,
                         rivetSize = rivetSize
        );
    }
}

// test code, will not be executed if this file is used.
girder(width = 12,
       thickness = 1,
       webThickness = 1,
       height = 60,
       length = 300,
       ribCount = 3,
       rivetSpacing = 6,
       rivetSize = 1.5);
