include <splitZbeltDeckPanel.scad>

Select = 0; // [0:splitZbeltDeckPanel_preview, 1:splitZbeltDeckPanel_left, 2:splitZbeltDeckPanel_right, 3:splitZbeltDeckPanel_center, 4:splitZbeltDeckPanel_baffle]

Raised = 0; // [0:Embossed, 1:Raised]

if (Select==0) {
    if (Raised==0) {
        splitZbeltDeckPanel_preview();
    }
    else {
        splitZbeltDeckPanel_previewRaised();
    }
} else if (Select==1) {
    if (Raised==0) {
        splitZbeltDeckPanel_left();
    }
    else {
        splitZbeltDeckPanel_leftRaised();
    }
} else if (Select==2) {
    if (Raised==0) {
        splitZbeltDeckPanel_right();
    }
    else {
        splitZbeltDeckPanel_rightRaised();
    }
} else if (Select==3) {
    splitZbeltDeckPanel_center();
} else if (Select==4) {
    splitZbeltDeckPanel_baffle();
}
                                                                                                                                