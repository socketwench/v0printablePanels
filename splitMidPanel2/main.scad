include <splitMidPanel2.scad>

Select = 0; // [0:Preview, 1:leftTop, 2:leftBottom, 3:centerTop, 4:centerBottom, 5:rightTop, 6:rightBottom]


module splitMidPanel2_preview() {
    translate([-1,1,0])
        splitMidPanel2_leftTop();
    translate([-1,-1,0])
        splitMidPanel2_leftBottom();

    translate([0,1,10])
        splitMidPanel2_centerTop();

    translate([0,-1,10])
        splitMidPanel2_centerBottom();

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
}