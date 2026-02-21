include <../m2_5/m2_5.scad>

module piDinRailMount_column(frameZ=1) {
    let(usbZ=7, colZ=usbZ+frameZ) {
        difference() {
            cylinder(h=colZ, d=6, $fn=25);
            
            translate([0,0,colZ-4.2])
                m2_5_ThreadedInsert();
        }
    }
}

module piDinRailMount_holePattern(center=false,holeDistance=58) {
    translate([center?holeDistance/-2:0,0]) {
        for (x = [0:holeDistance:holeDistance]) {
            translate([x,0,0])
                children();
        }
    }
}

module piDinRailMount_outline(holeDistance=58) {
    let(usbY=7, frameY=1, colY=usbY+frameY,dinY=35.4,holeX=holeDistance+6) {
        polygon([
            [0,0],
            [0,colY],
            [3,colY],
            [3,frameY],
            [holeX-3,frameY],
            [holeX-3,colY],
            [holeX,colY],
            // lever
            [holeX+5.8+10,colY],
            [holeX+5.8+12,colY-2],
            [holeX+5.8+12,colY-4],
            [holeX+5.8+10,colY-6],
            [holeX+4.8,colY-6],
            //clip
            [holeX+1,-3.4],
            [holeX-1,-3.4],
            [holeX-1,-2.6],
            [holeX+0.6,-1.2],
            [holeX+0.6,colY-4],
            [holeX+0.6+5.8,colY-2],
            [holeX+0.6+5.8,colY-1.6],
            [holeX+0.6,colY-1.6],
            [holeX,colY-1.6],
            // Pin
            [holeX,0],
            [holeX-dinY+1,0],
            [holeX-dinY+1,-1.2],
            [holeX-dinY+1+3,-2.6],
            [holeX-dinY+1+3,-3.4],
            [holeX-dinY-1,-3.4],
            [3,-3.4],
            [0,-1.2],
        ]);
    }
}

module piDinRailMount(holeDistance=58) {
    let(usbZ=7, frameZ=1, colZ=usbZ+frameZ) {
        union() {
            translate([3,-3,0])
                piDinRailMount_holePattern(center=false,holeDistance=holeDistance)
                    piDinRailMount_column(frameZ);

            difference() {
                rotate([90,0,0])
                    linear_extrude(6)
                        piDinRailMount_outline(holeDistance=holeDistance);
                
                translate([3,-3,0])
                    piDinRailMount_holePattern(center=false, holeDistance=holeDistance)
                        cylinder(h=colZ, d=6, $fn=25);
            }
        }
    }
}
