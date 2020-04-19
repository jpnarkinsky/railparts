use <../../components/rivets.scad>

/**
 * @param {Object} params - parameters
 * @param {number} params.width - brace width
 * @param {number} params.height - brace height
 * @param {number} params.depth - total brace depth
 * @param {number} params.thickness - material thickness
 * @param {number} params.thickness - corner thickness (i.e. after "carvout")
 */
module brace(width, height, depth, cornerWidth, thickness, rivetSpacing=6, rivetSize=1)
{
    radius = (width < height ? width : height) - cornerWidth;
    union() {
    linear_extrude(height=depth)
    {
        union()
        {
            difference()
            {
                square([ width, height ]);
                translate([ width, height ]) circle(r = radius);
                translate([ thickness, thickness ])
                    square([ width - 2 * thickness, height - 2 * thickness ]);
            };
            intersection()
            {
                difference()
                {
                    translate([ width, height ]) circle(r = radius);
                    translate([ width, height ]) circle(r = radius - thickness);
                };
                square([ width, height ]);
            };
        };
    };

    rotate([0,90,0]) 
      translate([-depth/4,2*thickness,0]) 
      rivetRow(length=width, spacing=rivetSpacing, rivetLength = 3 * thickness, rivetSize=rivetSize);
    rotate([0,90,0]) 
      translate([-3*depth/4,2*thickness,0]) 
      rivetRow(length=width, spacing=rivetSpacing, rivetLength = 3 * thickness, rivetSize=rivetSize);
    rotate([90,90,180]) 
      translate([-depth/4,thickness,0]) 
      rivetRow(length=height, spacing=rivetSpacing, rivetLength = 3 * thickness, rivetSize=rivetSize);
    rotate([90,90,180]) 
      translate([-3 * depth/4,thickness,0]) 
      rivetRow(length=height, spacing=rivetSpacing, rivetLength = 3 * thickness, rivetSize=rivetSize);
        
        
    
    translate([0,0,(depth - thickness) / 2]) linear_extrude(height=thickness) {
        difference() {
           square([width,height]);
           translate([ width, height ]) circle(r = radius - thickness);
        }
    }
  }
}

brace(width = 36, height = 36, depth = 12, cornerWidth = 12, thickness = 1);
