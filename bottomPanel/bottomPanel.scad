include <../BOSL2/std.scad>
include <../BOSL2/walls.scad>
include <../voronLogo/voronLogo.scad>

Select = 0; // [0:Preview, 1:topRight, 2:bottomRight, 3:topLeft, 4:bottomLeft, 5:centerWithLogo, 6:centerBlank]

module rectCycle(size, center=false) {
    let(w=size[0], h=size[1]) {
        translate([center ? w/-2 : 0, center ? h/-2 : 0]) {
            for(x=[0:1:1]) {
                for(y=[0:1:1]) {
                    translate([x*w,y*h])
                        children();
                }
            }
        }
    }
}

module circleRepeat(radius, angles=[]) {
    for (theta=angles)
        translate(polar_to_xy(radius,theta))
            children();
}

module bottomPanel_noCenterCutout() {
    union() {
        linear_extrude(3) {
            difference() {
                rect([213,213], rounding=16/2);

                rect([213-13*2,213-13*2], rounding=16/2);
                
                rectCycle([213-16,213-16], center=true)
                    circle(d=4.5, $fn=40);
            }
        }

        hex_panel([213-13*2,213-13*2,3], 3, (213-13*2)/12, frame = 0, anchor = BOTTOM);

        hex_panel([213-13*2,213-13*2,1], 1.5, (213-13*2)/36, frame = 0, anchor = BOTTOM);
    }
}

module bottomPanel_panelBoss(clearance=0) {
    linear_extrude(1.4) {
        difference() {
            union() {
                rotate([0,0,90])
                    difference() {
                        hexagon(d=90.2);
                        hexagon(d=70.2+clearance);
                    }
        
        circleRepeat(radius=35.8, angles=[30,150,210,330])
                    circle(d=16+clearance, $fn=20);
            }
                    
            circleRepeat(radius=35.8, angles=[30,150,210,330])
                circle(d=3.8, $fn=20);
        }
    }
}

module bottomPanel_centerScrewCutout() {
    union() {
        linear_extrude(0.8)
            rotate([0,0,90])
                hexagon(d=6.4);
        
        translate([0,0,-0.2])
            intersection() {
                translate([0,0,0.2])
                    cube([3.8,6.4,0.4], center=true);
                    
                linear_extrude(0.4)
                    rotate([0,0,90])
                        hexagon(d=6.4);
            }
    }
}

module bottomPanel_center(voronLogo=true) {
    difference() {
        linear_extrude(3)
            difference() {
                rotate([0,0,90])
                    hexagon(d=90);

                circleRepeat(radius=35.8, angles=[30,150,210,330])
                    circle(d=3.8, $fn=20);
            }

        if (voronLogo) {
            voronLogo_beveledStripes(3,-1);
        }
            
        bottomPanel_panelBoss(0.2);
        
        circleRepeat(radius=35.8, angles=[30,150,210,330])
            translate([0,0,2.21])
                bottomPanel_centerScrewCutout();
    }
}

module bottomPanel_withCenterCutout() {
    union() {
        difference() {
            bottomPanel_noCenterCutout();
            
            linear_extrude(3)
                rotate([0,0,90])
                    hexagon(d=90.2);
        }
        
        difference() {
            bottomPanel_panelBoss();
            
            circleRepeat(radius=35.8, angles=[30,150,210,330])
                cylinder(h=1, d1=3.8*2, d2=3.8, $fn=25);
        }
    }
}

module bottomPanel_topRight() {
    intersection() {
        translate([0,3.2,0])
            cube([213/2,213/2,3]);

        bottomPanel_withCenterCutout();
    }
}

module bottomPanel_bottomRight() {
    intersection() {
        translate([0, -213/2,0])
            cube([213/2,213/2+3.2,3]);

        bottomPanel_withCenterCutout();
    }
}

module bottomPanel_topLeft() {
    intersection() {
        translate([213/-2,3.2,0])
            cube([213/2,213/2,3]);

        bottomPanel_withCenterCutout();
    }
}

module bottomPanel_bottomLeft() {
    intersection() {
        translate([213/-2,213/-2,0])
            cube([213/2,213/2+3.2,3]);

        bottomPanel_withCenterCutout();
    }
}

module bottomPanel_preview() {
    translate([-1,-1,0])
        bottomPanel_bottomLeft();
    translate([1,1,0])
        bottomPanel_topRight();
    translate([1,-1,0])
        bottomPanel_bottomRight();
    translate([-1,1,0])
        bottomPanel_topLeft();
    translate([0,0,10])
        bottomPanel_center();
}

if (Select==0) {
    bottomPanel_preview();
} else if (Select==1) {
    bottomPanel_topRight();
} else if (Select==2) {
    bottomPanel_bottomRight();
} else if (Select==3) {
    bottomPanel_topLeft();
} else if (Select==4) {
    bottomPanel_bottomLeft();
} else if (Select==5) {
    bottomPanel_center(true);
} else if (Select==6) {
    bottomPanel_center(false);
}