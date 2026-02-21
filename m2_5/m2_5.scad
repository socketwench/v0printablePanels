module m2_5_ThreadedInsert() {
    cylinder(h=4.2, d=3.6, $fn=25);
}

module m2_5_mountingHole(height=4) {
    union() {
        translate([0,0,2])
            cylinder(h=height-2, d=4, $fn=25);

        cylinder(h=height, d=2.6, $fn=25); 
    }
}
