include <splitRearUpperPanel.scad>

Select = 0; // [0:Preview, 1:left, 2:right, 3:centerBlank, 4:centerVoron]


module splitRearUpperPanel_preview() {
    translate([-1,0,0])
        splitRearUpperPanel_left();

    translate([0,0,10])
        splitRearUpperPanel_centerVoron();

    translate([1,0,0])
        splitRearUpperPanel_right();
}

if (Select==0) {
    splitRearUpperPanel_preview();
} else if (Select==1) {
    splitRearUpperPanel_left();
} else if (Select==2) {
    splitRearUpperPanel_right();
} else if (Select==3) {
    splitRearUpperPanel_centerBlank();
} else if (Select==4) {
    splitRearUpperPanel_centerVoron();
}