// WORK IN PROGRESS!

difference() {
    union() {
      cube([170,45,4], false);
      translate([85,30,6]) scale([0.05,0.05,.05]) surface("../../railroads/chesapeake-and-ohio/logo-1948-55.png", center=true, invert=true);
      translate([85,5,3]) scale([1,1,5]) text("Louisa", halign="center");
    }
    translate([20,30,2])cylinder(h=5, r1=1.5, r2=1.5, center=true);
    translate([20,20,2])cylinder(h=5, r1=3, r2=3, center=true);
    translate([35,30,2])cylinder(h=5, r1=1.5, r2=1.5, center=true);
    translate([35,20,2])cylinder(h=5, r1=3, r2=3, center=true);
    translate([50,30,2])cylinder(h=5, r1=1.5, r2=1.5, center=true);
    translate([50,20,2])cylinder(h=5, r1=3, r2=3, center=true);
    translate([120,30,2])cylinder(h=5, r1=1.5, r2=1.5, center=true);
    translate([120,20,2])cylinder(h=5, r1=3, r2=3, center=true);
    translate([135,30,2])cylinder(h=5, r1=1.5, r2=1.5, center=true);
    translate([135,20,2])cylinder(h=5, r1=3, r2=3, center=true);
    translate([150,30,2])cylinder(h=5, r1=1.5, r2=1.5, center=true);
    translate([150,20,2])cylinder(h=5, r1=3, r2=3, center=true);
};
