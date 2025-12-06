include <deckPanel.scad>

Select = 0; // [0:Preview, 1:topRight, 2:bottomRight, 3:topLeft, 4:bottomLeft, 5:centerLower, 6:centerUpperFrame, 7:centerUpperBlank]

module deckPanel_centerPreview() {
    translate([0,0,12])
        deckPanel_centerUpperBlank();

    deckPanel_centerLower();
}

module deckPanel_preview() {
    
    translate([0,0,10])
        deckPanel_centerPreview();
    
    translate([1,1,0])
        deckPanel_bottomLeft();
    translate([-1,-1,0])
        deckPanel_topRight();
    translate([-1,1,0])
        deckPanel_bottomRight();
    translate([1,-1,0])
        deckPanel_topLeft();
}

if (Select==0) {
    deckPanel_preview();
} else if (Select==1) {
    deckPanel_topRight();
} else if (Select==2) {
    deckPanel_bottomRight();
} else if (Select==3) {
    deckPanel_topLeft();
} else if (Select==4) {
    deckPanel_bottomLeft();
} else if (Select==5) {
    deckPanel_centerLower();
} else if (Select==6) {
    deckPanel_centerUpperFrame();
} else if (Select==7) {
    deckPanel_centerUpperBlank();
}