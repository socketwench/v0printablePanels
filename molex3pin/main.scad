include <molex3pin.scad>

Select = 0; // [0:Preview, 1:portPanel, 2:housing]

if (Select==0) {
    molex3pin_preview();
} else if (Select==1) {
    molex3pin_portPanel();
} else if (Select==2) {
    molex3pin_housing();
} 