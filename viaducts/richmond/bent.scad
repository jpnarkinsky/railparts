use <../../components/girder.scad>
use <column.scad>
use <brace.scad>

module bent(width,
            height,
            depth,
            girderHeight,
            girderThickness,
            braceThickness,
            rivetSpacing = 6,
            rivetSize = 1.5)
{
    translate([ depth, 0, 0 ])
    {
        rotate([ 0, 0, 90 ]) union()
        {
            translate([ 0, braceThickness, height - girderHeight ])
                rotate([ 90, 0, 0 ]) girder(width = depth,
                                            webThickness = girderThickness,
                                            thickness = braceThickness,
                                            height = girderHeight,
                                            ribCount = 3,
                                            length = (width - 2 * depth - braceThickness),
                                            rivetSpacing = rivetSpacing,
                                            rivetSize = rivetSize);
            column(width = depth,
                   depth = depth,
                   length = height,
                   thickness = braceThickness,
                   rivetSpacing = rivetSpacing,
                   rivetSize = rivetSize);
            translate([ 0, -width + depth, 0 ])
                column(width = depth,
                       depth = depth,
                       length = height,
                       thickness = braceThickness,
                       rivetSpacing = rivetSpacing,
                       rivetSize = rivetSize);

            translate([0, 0, height-girderHeight]) 
              rotate([-90,0,-90]) brace(36, 36, depth, 12, braceThickness);
            translate([depth, -width + 2 * depth + 2* braceThickness, height-girderHeight]) 
              rotate([-90,0,90]) brace(36, 36, depth, 12, braceThickness);
        };
    };
};
bent(width = 24 * 12,
     height = 12 * 12,
     depth = 12,
     girderHeight = 5 * 12,
     girderThickness = 1,
     braceThickness = 1);



