include <../BOSL2/std.scad>
include <../BOSL2/walls.scad>
include <../circles/circles.scad>
include <../m3/m3.scad>
include <../voronLogo/voronLogo.scad>

module splitRearUpperPanel_singlePiece(w=212, h=63) {
    cube([w,h,0.4], anchor=BOTTOM);

    hex_panel([w,h,2.6], strut=3, spacing=(213-13*2)/12, frame = 3, anchor=BOTTOM);

    hex_panel([w,h,0.8], strut=1.5, spacing=(213-13*2)/36, frame = 3, anchor=BOTTOM);
}

module splitRearUpperPanel_centerHolePattern() {
    circleRepeat(radius=43/2, angles=[30,150,210,330])
        children();
}

module splitRearUpperPanel_centerBoss(screwHoles=true, clearance=0) {
    linear_extrude(2.6/2) {
        difference() {
            union() {
                rotate([0,0,90])
                    difference() {
                        hexagon(d=63);
                        hexagon(d=43-clearance*2);
                    }
                
                splitRearUpperPanel_centerHolePattern()
                    circle(d=16+clearance*2, $fn=20);
            }
            
            if (screwHoles) {
                splitRearUpperPanel_centerHolePattern()
                    circle(d=3.8, $fn=20);
            }
        }
    }
}

module splitRearUpperPanel_withCenterCutout(w=212, h=63) {
    union() {
        difference() {
            splitRearUpperPanel_singlePiece();
            
            linear_extrude(2.6)
                rotate([0,0,90])
                    hexagon(d=63);
        }

        difference() {
            splitRearUpperPanel_centerBoss();
            
            splitRearUpperPanel_centerHolePattern()
                    m3FHCS_counterSinkCutout(2.6);
        }
        
    }
}

module splitRearUpperPanel_centerScrewCutout() {
    union() {
        translate([0,0,2.6-0.4])
            linear_extrude(0.4)
                rotate([0,0,90])
                    hexagon(d=6.6);
        
        translate([0,0,2.6-0.6])
            intersection() {
                cube([3.8,6.6,0.4], center=true);
                
                linear_extrude(0.4)
                    rotate([0,0,90])
                        hexagon(d=6.6);
            }
            
        cylinder(h=2.6, d=3.8, $fn=25);
    }
}

module splitRearUpperPanel_centerBlank(clearance=0.4) {
    difference() {            
        linear_extrude(2.6)
            rotate([0,0,90])
                hexagon(d=63-clearance);

        splitRearUpperPanel_centerBoss(screwHoles=false, clearance=clearance);
        
        splitRearUpperPanel_centerHolePattern()
            splitRearUpperPanel_centerScrewCutout();
    }
}

module splitRearUpperPanel_centerVoron() {
    difference() {
        splitRearUpperPanel_centerBlank();
        
        translate([0,0,2.6-0.4])
            linear_extrude(0.4)
                scale([0.6,0.6,0.6])
                    voronLogo_shape();
    }
}

module splitRearUpperPanel_left() {
    intersection() {
        cube([212/2,63,2.6], anchor=BOTTOM+RIGHT);
        splitRearUpperPanel_withCenterCutout();
    }
}

module splitRearUpperPanel_right() {
    intersection() {
        cube([212/2,63,2.6], anchor=BOTTOM+LEFT);
        splitRearUpperPanel_withCenterCutout();
    }
}
