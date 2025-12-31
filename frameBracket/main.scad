include <frameBracket.scad>

Select = 0; //[0:noMagnets, 1:withMagnets, 2:50mmCuttingGuide]

magnetHeight=3.2;
magnetDiameter=6.2;
embossTop=true;
embossBottom=true;

if (Select == 0) {
    frameBracket(embossTop, embossBottom);
} else if (Select == 1) {
    frameBracket_withMagnets(magnetHeight, magnetDiameter);
} else if (Select == 2) {
    frameBracket_50mmCuttingGuide();
}
