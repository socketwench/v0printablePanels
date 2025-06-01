include <../m3/m3.scad>
include <../hexagons/hexagons.scad>
include <../midPanel/midPanel.scad>
include <../molex3pin/molex3pin.scad>

midPanelX = 230;
midPanelY = 170;
// 10mm plus half the height of the hole.
holeInset = 7 + 4/2;
// 3 for left and right, 4 for the middle.
holeCountPerColumn = 3 + 6;
// The space between each hole centerline.
holeSpacing = (midPanelY-(holeInset*2))/(holeCountPerColumn-1);
tabX = 10;
tabY = holeSpacing*2;
tabInset = holeInset+(holeSpacing/2);


module splitMidPanel_centerTabColumn() {
    translate([0,tabInset+tabY/2])
        square([tabX,tabY], center=true);
    translate([0,midPanelY-tabY-tabInset+tabY/2])
        square([tabX,tabY], center=true);
}

module splitMidPanel_centerTabs(mountHoleCenterlineX=15+58+(15/2)) {
    translate([mountHoleCenterlineX,0])
            splitMidPanel_centerTabColumn();
    translate([midPanelX-mountHoleCenterlineX,0])
        splitMidPanel_centerTabColumn();
}

module splitMidPanel_centerOutline(mountHoleCenterlineX=15+58+(15/2)) {
    difference() {  
        union() {
            splitMidPanel_centerTabs();
            
            translate([mountHoleCenterlineX+tabX/2,0])
                square([midPanelX-mountHoleCenterlineX*2-tabX,midPanelY]);
        }
        
        midPanel_holes();
        
        midPanel_zBeltCutout();
    }
}

module splitMidPanel_centerOutlineTest() {
    linear_extrude(0.6)
        difference() {
            splitMidPanel_centerOutline();
            
            offset(delta=-10)
                splitMidPanel_centerOutline();
        }
}

module splitMidPanel_centerText() {
    let(fontSize=18) {
        rotate([0,0,90]) {
            translate([-fontSize*3,-fontSize,0])
                text("Voron", size=fontSize, halign="right", font="Play");
            
            translate([0,-fontSize,0])
                text("Zero", size=fontSize, halign="right", font="Play:style=Bold");
        }
    }
}

module splitMidPanel_center() {
    difference() {
        linear_extrude(2.6)
            splitMidPanel_centerOutline();
        
        translate([midPanelX/2,midPanelY-5,0])
            linear_extrude(1.2)
                mirror([1,0,0])
                    splitMidPanel_centerText();
    }
}

module splitMidPanel_sideOutline() {
    difference() {
        midPanel_Outline();
        offset(delta=0.2)
            splitMidPanel_centerOutline();
    }
}

module splitMidPanel_leftOutline() {
    intersection() {
        splitMidPanel_sideOutline();
        square([midPanelX/2,midPanelY]);
    }
}

module splitMidPanel_leftOutlineTest() {
    linear_extrude(0.6)
        difference() {
            splitMidPanel_leftOutline();
            
            offset(delta=-10)
                splitMidPanel_leftOutline();
        }
}

module splitMidPanel_right() {
    difference() {
        linear_extrude(2.6)
            splitMidPanel_leftOutline();
        
        translate([4,8,0])
            beveledHexagonPanel(22,2,3,58+15-8, midPanelY-16,1.2, 17.3, 11);
        
        translate([5+2.6,5,0])
            m3FHCS_counterSinkCutout(2.6);
        
        translate([5+2.6,midPanelY-5,0])
            m3FHCS_counterSinkCutout(2.6);
    
        translate([5+2.6,35,0])
            rotate([0,0,-90])
                molex3pin_portPanelCutout();
    
        translate([5+2.6,midPanelY/2,0])
            rotate([0,0,-90])
                molex3pin_portPanelCutout();
    
        translate([5+2.6,midPanelY-35,0])
            rotate([0,0,-90])
                molex3pin_portPanelCutout();
    }
}

module splitMidPanel_left() {
    translate([midPanelX,0,0])
        mirror([1,0,0])
            splitMidPanel_right();
}

module splitMidPanel_leftWithRibbonCutout() {
    let(ribbonOffsetX=58+16,ribbonOffsetY=2.6,ribbonWidth=30) {
        union() {
            difference() {
                splitMidPanel_left();
                
                translate([midPanelX-ribbonOffsetX, midPanelY-ribbonOffsetY/2, 0])
                    cube([ribbonWidth,ribbonOffsetY/2+0.4,2.6]);
            }
            
            translate([midPanelX-ribbonOffsetX, midPanelY-ribbonOffsetY/2-0.4, ribbonOffsetY/2])
                rotate([0,90,0])
                    cylinder(h=ribbonWidth, d=ribbonOffsetY, $fn=25);
        }
    }
}