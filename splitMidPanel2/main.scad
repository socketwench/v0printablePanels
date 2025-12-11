include <splitMidPanel2.scad>

Select = 0; // [0:Preview, 1:leftTop, 2:leftBottom, 3:centerTop, 4:centerBottom, 5:rightTop, 6:rightBottom, 7:voronCenterTop, 8:voronCenterBottom]


module splitMidPanel2_centerVoronText() {
    let(fontSize=18) {
        rotate([0,0,90]) {
            translate([-fontSize*2.95,-fontSize,0])
                text("Voron", size=fontSize, halign="right", font="Play");
            
            translate([0,-fontSize,0])
                text("Zero", size=fontSize, halign="right", font="Play:style=Bold");
        }
    }
}

module splitMidPanel2_centerVoron() {
    difference() {
        splitMidPanel2_center();
        
        translate([0,170/2-5,2.6-0.4])
            linear_extrude(0.4)
                splitMidPanel2_centerVoronText();
    }
}

module splitMidPanel2_centerVoronTop() {
    intersection() {
        splitMidPanel2_centerVoron();
        splitMidPanel2_topCutout();
    }
}

module splitMidPanel2_centerVoronBottom() {
    intersection() {
        splitMidPanel2_centerVoron();
        splitMidPanel2_bottomCutout();
    }
}

module splitMidPanel2_preview() {
    translate([-1,1,0])
        splitMidPanel2_leftTop();
    translate([-1,-1,0])
        splitMidPanel2_leftBottom();

    translate([0,1,10])
        splitMidPanel2_centerVoronTop();

    translate([0,-1,10])
        splitMidPanel2_centerVoronBottom();

    translate([1,1,0])
        splitMidPanel2_rightTop();
    translate([1,-1,0])
        splitMidPanel2_rightBottom();
}

if (Select==0) {
    splitMidPanel2_preview();
} else if (Select==1) {
    splitMidPanel2_leftTop();
} else if (Select==2) {
    splitMidPanel2_leftBottom();
} else if (Select==3) {
    splitMidPanel2_centerTop();
} else if (Select==4) {
    splitMidPanel2_centerBottom();
} else if (Select==5) {
    splitMidPanel2_rightTop();
} else if (Select==6) {
    splitMidPanel2_rightBottom();
} else if (Select==7) {
    splitMidPanel2_centerVoronTop();
} else if (Select==8) {
    splitMidPanel2_centerVoronBottom();
}