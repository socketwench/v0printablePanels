include <splitMidPanel.scad>

Select = 0; // [0:left, 1:center, 2:right, 3:centerTest,4:leftTest]

if (Select==0) {
    splitMidPanel_leftWithRibbonCutout();
} else if (Select==1) {
    splitMidPanel_center();
} else if (Select==2) {
    splitMidPanel_right();
} else if (Select==3) {
    splitMidPanel_centerOutlineTest();
} else if (Select==4) {
    splitMidPanel_leftOutlineTest();
}