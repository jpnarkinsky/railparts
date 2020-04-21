// WORK IN PROGRESS!

difference() {
    union() {
      cube([170,45,4], false);
      translate([85,22.5,6]) scale([0.05,0.05,0.02]) surface("../../railroads/chesapeake-and-ohio/logo-1948-55.png", center=true, invert=true);
      translate([10,30,6]) scale([1,1,1.5]) text("Louisa", center=true);
    }
    translate([20,22.5,2])cylinder(h=5, r1=3, r2=3, center=true);
    translate([35,22.5,2])cylinder(h=5, r1=3, r2=3, center=true);
    translate([50,22.5,2])cylinder(h=5, r1=3, r2=3, center=true);
    translate([50,22.5,2])cylinder(h=5, r1=3, r2=3, center=true);
    translate([60,22.5,2])cylinder(h=5, r1=3, r2=3, center=true);
    translate([70,22.5,2])cylinder(h=5, r1=3, r2=3, center=true);

};
