include <../hexagons/hexagons.scad>

module voronLogo_stripeShapeLeft() { 
    polygon([
        [-0.4,-18.2],
        [9,-18.2],
        [21.7,0],
        [12.2,0]
    ]);
}

module voronLogo_stripeShapeCenter() {
    polygon([
        [-17.2,-18.2],
        [-7.9,-18.2],
        [17.3,18.2],
        [8,18.2]
    ]);
}

module voronLogo_stripeShapeRight() {
    polygon([
        [-21.4,0],
        [-12.1,0],
        [0.55,18.2],
        [-8.9,18.2]
    ]);
}

module voronLogo_hexShape() {
    rotate([0,0,90])
        hexagon(or=32.9);
}

module voronLogo_beveledStripes(height, bevel) {
    union () {
        hull() {
            linear_extrude(.01) 
               voronLogo_stripeShapeLeft();
            
            translate([0,0,height]) 
                linear_extrude(.01)
                    offset(delta=-1*bevel)
                        voronLogo_stripeShapeLeft();
        }
        
        hull() {
            linear_extrude(.01) 
               voronLogo_stripeShapeCenter();
            
            translate([0,0,height]) 
                linear_extrude(.01)
                    offset(delta=-1*bevel)
                        voronLogo_stripeShapeCenter();
        }
        
        hull() {
            linear_extrude(.01) 
               voronLogo_stripeShapeRight();
            
            translate([0,0,height]) 
                linear_extrude(.01)
                    offset(delta=-1*bevel)
                        voronLogo_stripeShapeRight();
        }
    }
}

module voronLogo_beveled(height, bevel) {
    difference() {
        beveledHexagon((32.9-bevel)*2, 0, bevel*-1, height);
        voronLogo_beveledStripes(height-0.2, bevel);
    }
}
