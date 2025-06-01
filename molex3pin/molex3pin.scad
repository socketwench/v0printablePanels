include <../m3/m3.scad>

module molex3pin_portCutoutOutline(center=true) { 
    let(connX=14.6, connY=4.2, latchX=3, latchY=1.4) {
        translate([center ? -connX/2 : 0, center ? -connY/2 : 0])
        polygon([
            [0,0],
            [connX,0],
            [connX,connY],
            [connX/2+latchX/2,connY],
            [connX/2+latchX/2,connY+latchY],
            [connX/2-latchX/2,connY+latchY],
            [connX/2-latchX/2,connY],
            [0,connY]
        ]);
    }
}

module molex3pin_housingCutoutOutline(center=true) {
    let(housingX=10.4, housingY=5.6, pinX=2.4, pinY=1) {
        translate([center ? -housingX/2 : 0, center ? -housingY/2 : 0])
            polygon([
                [0,0],
                [pinX,0],
                [pinX,pinY],
                [housingX-pinX,pinY],
                [housingX-pinX,0],
                [housingX,0],
                [housingX,housingY],
                [housingX-pinX,housingY],
                [housingX-pinX,housingY-pinY],
                [pinX,housingY-pinY],            
                [pinX,housingY],
                [0,housingY]
            ]);
    }
}

module molex3pin_housingOutline() {
    union() {
        molex3pin_portCutoutOutline(true);
        molex3pin_housingCutoutOutline(true);
    }
}

module molex3pin_housing() {
    difference() {
        linear_extrude(9-2.6)
            difference() {
                translate([0,0.2])
                    square([19+4.8*2+2.8,9.6], center=true);
                molex3pin_housingOutline();
            }
        
        translate([19/2+4.8/2,0,0])
            m3x5x4_ThreadedInsert();
            
        translate([-19/2-4.8/2,0,0])
            m3x5x4_ThreadedInsert();
    }
}

module molex3pin_portPanelCutout() {
    union() {
        linear_extrude(2.6)
            molex3pin_housingOutline();
        
        translate([-19/2-4.8/2,0,0])
            m3FHCS_counterSinkCutout();

        translate([19/2+4.8/2,0,0])
            m3FHCS_counterSinkCutout();  
    }
}

module molex3pin_portPanel() {
    difference() {
        linear_extrude(2.6)
            square([33,10], center=true);
        
        molex3pin_portPanelCutout();
    }
}

module molex3pin_preview() {
    molex3pin_portPanel();
    
    translate([0,0,2.6]) molex3pin_housing();
}
