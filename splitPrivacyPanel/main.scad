include <splitPrivacyPanel.scad>

Select = 0; // [0:Preview, 1:privacyPanelTop, 2:privacyPanelBottom, 3:centerBlank, 4:centerVoron]


module splitPrivacyPanel_preview() {
    translate([0,1,0])
        splitPrivacyPanel_top();

    translate([0,0,10])
        splitPrivacyPanel_centerVoron();

    translate([0,-1,0])
        splitPrivacyPanel_bottom();
}

if (Select==0) {
    splitPrivacyPanel_preview();
} else if (Select==1) {
    splitPrivacyPanel_top();
} else if (Select==2) {
    splitPrivacyPanel_bottom();
} else if (Select==3) {
    splitPrivacyPanel_centerBlank();
} else if (Select==4) {
    splitPrivacyPanel_centerVoron();
}