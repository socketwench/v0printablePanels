include <privacyPanel.scad>

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

Select = 0; // [0:Preview, 1:privacyPanelLeft, 2:privacyPanelRight, 3:bracketA, 4:bracketB]

module preview() {
    
    rotate([90,0,0]) {
        translate([0,0,2.8])
            rotate([0,90,0])
                privacyPanel_left();

        translate([midPanelX,0,2.8])
            rotate([0,-90,0])
                privacyPanel_right();
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
}

if (Select==0) {
    preview();
} else if (Select==1) {
    privacyPanel_left();
} else if (Select==2) {
    privacyPanel_right();
} else if (Select==3) {
    privacyPanel_bracketA();
} else if (Select==4) {
    privacyPanel_bracketB();
}
