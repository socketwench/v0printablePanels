include <../BOSL2/std.scad>
include <../BOSL2/walls.scad>
include <../circles/circles.scad>
include <../m3/m3.scad>

function deckPanel_points() = [
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
    [63,25],
    [63,19],
    [46,19],
    [46,0]
];

module deckPanel_outline(center=true) {
    translate([center ? 209/-2 :  0, center ? 172/-2 : 0]) {
        polygon(deckPanel_points());
    }
}

module deckPanel_holesPattern() {
    circleRepeat(radius=45.8, angles=[30,150,210,330])
        children();
    
    circleRepeat(radius=41.6, angles=[70,110,250,290])
        children();
}


module deckPanel_screwHoles() {
    deckPanel_holesPattern()
        circle(d=3.8, $fn=20);
}

module deckPanel_panelBoss(clearance=0, holes=true) {
    linear_extrude(1.2) {
        difference() {
            union() {
                rotate([0,0,90])
                    difference() {
                        hexagon(d=110);
                        hexagon(d=90-clearance*2);
                    }
        
                    deckPanel_holesPattern()
                        circle(d=13+clearance*2, $fn=20);

            }
            
            if (holes) {
                deckPanel_screwHoles();
            }
        }
    }
}

module deckPanel_singlePiece() {
    difference() {
        union() {
            translate([209/-2, 172/-2,2.6/2])
                hex_panel(deckPanel_points(), strut=3, spacing=(213-13*2)/12, h = 2.6, frame = 6);
            
             translate([209/-2, 172/-2,0.8/2])
                hex_panel(deckPanel_points(), strut=1.5, spacing=(213-13*2)/36, h = 0.8, frame = 6);
            
            linear_extrude(0.4)
                deckPanel_outline();
        }
        
        linear_extrude(2.6)
            translate([0,25/2])
                rotate([0,0,90])
                    hexagon(d=110);
    }

    translate([0,25/2])
        deckPanel_panelBoss();
}

module deckPanel_centerLower() {
    difference() {
        linear_extrude(2.6)
            difference() {
                rotate([0,0,90])
                    hexagon(d=110);
                
                deckPanel_screwHoles();
            }
        
        deckPanel_panelBoss(clearance=0.2, holes=false);
    }
}

module deckPanel_centerUpperFrame() {
    difference() {
        rotate([0,0,90]) {
            difference() {
                regular_prism(6, r1=110/2, height=6, ang=70, anchor=BOTTOM);

                regular_prism(6, r1=78/2, height=6, ang=110, anchor=BOTTOM);
            }
        }
        deckPanel_holesPattern()
            m3x5x4_ThreadedInsert();
    }
}

module deckPanel_centerUpperBlank() {
    union() {
        linear_extrude(0.6) {
            rotate([0,0,90])
                hexagon(d=78);
        }
        
        deckPanel_centerUpperFrame();
    }
}

module deckPanel_bottomLeft() {
    intersection() {
        translate([0,3.6,0])
            cube([209/2,172/2,3]);

        deckPanel_singlePiece();
    }
}

module deckPanel_topLeft() {
    intersection() {
        translate([0, -172/2,0])
            cube([209/2,172/2+3.6,3]);

        deckPanel_singlePiece();
    }
}

module deckPanel_bottomRight() {
    intersection() {
        translate([209/-2,3.6,0])
            cube([209/2,172/2,3]);

        deckPanel_singlePiece();
    }
}

module deckPanel_topRight() {
    intersection() {
        translate([209/-2,172/-2,0])
            cube([209/2,172/2+3.6,3]);

        deckPanel_singlePiece();
    }
}
