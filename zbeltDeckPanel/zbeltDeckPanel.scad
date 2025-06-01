include <../BOSL2/std.scad>
include <../hexagons/hexagons.scad>
include <../voronLogo/voronLogo.scad>

module zbeltDeckPanel_hexStack() {
    difference() {
        union() {
            translate([0,0,3]) 
                mirror([0,0,1]) 
                    beveledHexagonPanel(22,2,3,209/2-27,172+2.5,1.2,11,0);

            translate([209,0,3]) 
                mirror([0,0,1]) 
                    mirror([1,0,0]) 
                        beveledHexagonPanel(22,2,3,209/2-27,172+2.5,1.2,11,0);
        }
        
        translate([209/2,172/2+8,3-1.2])
            scale([1.8,1.8,1]) 
                rotate([0,0,90]) {
                    linear_extrude(3)
                        hexagon(od=(32.9+7.8)*2);
                }
        }
}

module zbeltDeckPanel_outline() {
    polygon([
        [0,0],
        [0,166],
        [6,166],
        [6,172],
        [203,172],
        [203,166],
        [209,166],
        [209,0],
        [147,0],
        [147,25],
        [130,25],
        [130,0],
        [78,0],
        [78,19],
        [46,19],
        [46,0]
    ]);
}

module zbeltDeckPanel_fitTest() {
    difference() {
        linear_extrude(.6) zbeltDeckPanel_outline();
        
        linear_extrude(.6) 
            offset(delta=-10)
                zbeltDeckPanel_outline();
    }
}

module zbeltDeckPanel() {
    difference() {
        linear_extrude(2.6)
            zbeltDeckPanel_outline();

        intersection() {
            linear_extrude(2.6)
                offset(delta=-5)
                    zbeltDeckPanel_outline();
            
            zbeltDeckPanel_hexStack();
        }
        
        translate([209/2,172/2+8,3-1.2])
            scale([1.8,1.8,1])
                voronLogo_beveled(1.2,3);
    }
}