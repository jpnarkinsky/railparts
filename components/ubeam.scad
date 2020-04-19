/**
 * height - beam height
 * length - beam length
 * thickness - material thickness
 * width - beam width
 */
module uBeam(height,width,length,thickness) {
  union() {
    cube([thickness,width,length]);
    translate([thickness,0,0]) rotate([0,0,90]) cube([thickness,height,length]);
    translate([thickness, width - thickness,0]) rotate([0,0,90]) cube([thickness, height,length]);
      
   // translate([0,thickness,0]) cube([height - thickness, width -  2 * thickness, length]);
  }
}

uBeam(6,12,240,1);
