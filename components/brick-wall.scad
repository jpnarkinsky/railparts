brick_x = 7.625;
brick_y = 3.625;
brick_z = 2.25;

spacing_x = .375;
spacing_y = .25;
recess = .250;

module brick_wall(width,
                  height,
                  thickness = (brick_y + recess),
                  parity = 0)
{
    union()
    {
        translate([ 0, 2 * recess, 0 ]) cube([
            (brick_x + spacing_x) * (width + 1.5 ) - 2*spacing_x,
            (thickness * brick_z - recess),
            (brick_z + spacing_y) *
            height
        ]);
        for (i = [0:height]) {
            for (j = [0:width]) {
                translate([
                    j * (brick_x + spacing_x) +
                        (i % 2 + parity) * .5 * brick_x,
                    recess,
                    i * brick_z + spacing_y / 2
                ])
                    cube([
                        brick_x - spacing_x,
                        recess,
                        brick_z -
                        spacing_y
                    ]);
            }
        }
    }
}

brick_wall(10, 10);
