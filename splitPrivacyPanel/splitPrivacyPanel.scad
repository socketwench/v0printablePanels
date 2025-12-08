include <../BOSL2/std.scad>
include <../BOSL2/walls.scad>
include <../circles/circles.scad>
include <../m3/m3.scad>
include <../voronLogo/voronLogo.scad>

/*
difference() {
    square([34,170], center=tru0.e);
    rotate([0,0,90])
        hexagon(d=34);
}
*/

module splitPrivacyPanel_singlePiece(fillIn=false) {
    let(privacyPanelX=34, privacyPanelY=170) {
        difference() {
            union() {
                if (fillIn) {
                    cube([privacyPanelX,privacyPanelY,0.4], anchor=BOTTOM);
                }

                hex_panel([privacyPanelX,privacyPanelY,2.6], strut=3, spacing=(213-13*2)/12, frame = 3, anchor=BOTTOM);

                hex_panel([privacyPanelX,privacyPanelY,0.8], strut=1.5, spacing=(213-13*2)/36, frame = 3, anchor=BOTTOM);
                
                translate([privacyPanelX/2-5,privacyPanelY/2-5,0])
                    cylinder(h=2.6, d=10, $fn=20);
                
                translate([privacyPanelX/2-5,privacyPanelY/-2+5,0])
                    cylinder(h=2.6, d=10, $fn=20);
            }
            
            translate([privacyPanelX/2-5,privacyPanelY/2-5,2.6])
                mirror([0,0,1])
                    m3FHCS_counterSinkCutout(2.6);
            
            translate([privacyPanelX/2-5,privacyPanelY/-2+5,2.6])
                mirror([0,0,1])
                    m3FHCS_counterSinkCutout(2.6);
        }
    }
}

module splitPrivacyPanel_centerHolePattern() {
    circleRepeat(radius=24/2, angles=[30,150,210,330])
        children();
}

module splitPrivacyPanel_centerBoss(screwHoles=true, clearance=0) {
    linear_extrude(2.6/2) {
        difference() {
            union() {
                rotate([0,0,90])
                    difference() {
                        hexagon(d=34);
                        hexagon(d=24-clearance*2);
                    }
                
                splitPrivacyPanel_centerHolePattern()
                    circle(d=8-clearance*2, $fn=20);
            }
            
            if (screwHoles) {
                splitPrivacyPanel_centerHolePattern()
                    circle(d=3.8, $fn=20);
            }
        }
    }
}     

module splitPrivacyPanel_withCenterCutout(fillIn=false) {
    union() {
        difference() {
            splitPrivacyPanel_singlePiece(fillIn);
            
            linear_extrude(2.6)
                rotate([0,0,90])
                    hexagon(d=34);
        }

        splitPrivacyPanel_centerBoss();
    }
}

module splitPrivacyPanel_centerBlank() {
    difference() {            
        linear_extrude(2.6)
            rotate([0,0,90])
                hexagon(d=34);

        splitPrivacyPanel_centerBoss(screwHoles=false, clearance=0.2);
        
        translate([0,0,2.6])
            splitPrivacyPanel_centerHolePattern()
                mirror([0,0,1])
                    m3FHCS_counterSinkCutout(2.6);
    }
}

module splitPrivacyPanel_centerVoron() {
    difference() {
        splitPrivacyPanel_centerBlank();
        
        translate([0,0,2.6-0.4])
            linear_extrude(0.4)
                scale([0.3,0.3,0.3])
                    voronLogo_shape();
    }
}

module splitPrivacyPanel_top() {
    intersection() {
        cube([34,170/2,2.6], anchor=BOTTOM+FRONT);
        splitPrivacyPanel_withCenterCutout();
    }
}

module splitPrivacyPanel_bottom() {
    intersection() {
        cube([34,170/2,2.6], anchor=BOTTOM+BACK);
        splitPrivacyPanel_withCenterCutout();
    }
}
