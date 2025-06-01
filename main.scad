include <midPanel/midPanel.scad>
include <privacyPanel/privacyPanel.scad>
include <splitMidPanel/splitMidPanel.scad>
include <zbeltDeckPanel/zbeltDeckPanel.scad>
include <splitZbeltDeckPanel/splitZbeltDeckPanel.scad>

include <BOSL2/std.scad>
include <BOSL2/walls.scad>


midPanelX = 230;
midPanelY = 170;
privacyPanelX = 34;
privacyPanelY = midPanelY;
// A 1515, 58mm space (page 34), and half a 1515.
mountHoleCenterlineX=15+58+(15/2);
// 10mm plus half the height of the hole.
holeInset = 7 + 4/2;
// 3 for left and right, 4 for the middle.
holeCountPerColumn = 3 + 6;
// The space between each hole centerline.
holeSpacing = (midPanelY-(holeInset*2))/(holeCountPerColumn-1);
tabX = 10;
tabY = holeSpacing*2;
tabInset = holeInset+(holeSpacing/2);


Select = 0; // [0:Preview, 1:fullMidpanel, 2:splitMidpanelCenter, 3:splitMidpanelLeft, 4:splitMidpanelRight, 5:privacyPanelLeft, 6:privacyPanelRight,7:fullDeckpanel,8:splitDeckpanelLeft, 9:splitDeckpanelRight, 10:splitDeckpanelCenter, 11:splitDeckpanelBaffle, 12:bracketA, 13:bracketB]

Raised = 0; // [0:Embossed, 1:Raised]

module preview() {
    
    rotate([90,0,0]) {
        translate([0,0,2.8])
            rotate([0,90,0])
                privacyPanel_left();
        splitMidPanel_leftWithRibbonCutout();
        
        translate([0,0,0]) {
            splitMidPanel_center();
            translate([0,0,0]) {
                splitMidPanel_right();
                translate([midPanelX,0,2.8])
                    rotate([0,-90,0])
                        privacyPanel_right();
            }
        }
    }
    
    translate([2.8,-34-2.8,0])
        rotate([0,90,0])
            rotate([0,0,90])
                privacyPanel_bracketB();

    translate([12+2.8,-34-2.8,midPanelY])
        rotate([0,-90,0])
            rotate([0,0,90])
                privacyPanel_bracketA();

    translate([midPanelX-2.8-12,-34-2.8,0])
        rotate([0,90,0])
            rotate([0,0,90])
                privacyPanel_bracketA();

    translate([midPanelX-2.8,-34-2.8,midPanelY])
        rotate([0,-90,0])
            rotate([0,0,90])
                privacyPanel_bracketB();

    translate([(midPanelX-209)/2,0,0]){        
        if (Raised==0) {
            splitZbeltDeckPanel_preview();
        }
        else {
            splitZbeltDeckPanel_previewRaised();
        }
    }
}

if (Select==0) {
    preview();
} else if (Select==1) {
    midPanel();
} else if (Select==2) {
    splitMidPanel_center();
} else if (Select==3) {
    splitMidPanel_leftWithRibbonCutout();
} else if (Select==4) {
    splitMidPanel_right();
} else if (Select==5) {
    privacyPanel_left();
} else if (Select==6) {
    privacyPanel_right();
} else if (Select==7) {
    zbeltDeckPanel();
} else if (Select==8) {
    splitZbeltDeckPanel_left();
} else if (Select==9) {
    splitZbeltDeckPanel_right();
} else if (Select==10) {
    splitZbeltDeckPanel_center();
} else if (Select==11) {
    splitZbeltDeckPanel_baffle();
} else if (Select==12) {
    privacyPanel_bracketA();
} else if (Select==13) {
    privacyPanel_bracketB();
}
