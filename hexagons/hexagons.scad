include <../BOSL2/std.scad>
include <../BOSL2/coords.scad>

module beveledHexagon(diameter, space, bevel, height) {
    rotate([0,0,90])
        hull() {
            linear_extrude(.01) 
                offset(delta=-1*space)
                    hexagon(od=diameter);
            
            translate([0,0,height]) 
                linear_extrude(.01)
                    offset(delta=-1*(space+bevel))
                        hexagon(od=diameter);
        }
}


module beveledHexagonGrid(diameter, space, bevel, height, gridX, gridY) {
    radius = diameter / 2;
    x_delta = radius * sin(60);
    y_delta = radius * (1 + cos(60));
    rows = ceil((gridY/y_delta)/2)+1;
    columns = floor(gridX/x_delta);

    union() {
        for (r=[0:1:rows - 1]) {
            translate([0, 2 * y_delta * r, 0]) {
                for (c=[0:2:columns + 2]) {
                    translate([x_delta * c, 0, 0])
                        beveledHexagon(diameter, space, bevel, height);
                }

                for (c=[1:2:columns + 2]) {
                    translate([x_delta * c, y_delta, 0])
                        beveledHexagon(diameter, space, bevel, height);
                }
            }
        }
    }
}

module beveledHexagonPanel(diameter, space, bevel, panelX, panelY, panelZ, offsetX=0, offsetY=0) {    
    intersection() {
        cube([panelX, panelY, panelZ]);
        translate([offsetX, offsetY, 0])
            beveledHexagonGrid(diameter,space,bevel,panelZ,panelX,panelY);
    }
}

module hexCycle(radius, start=0) {
    for (theta=[start:60:360+start])
        translate(polar_to_xy(radius,theta))
            children();
}
