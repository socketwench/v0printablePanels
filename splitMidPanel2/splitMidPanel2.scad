include <../BOSL2/std.scad>
include <../BOSL2/walls.scad>
include <../rectangles/rectangles.scad>
include <../m3/m3.scad>
include <../molex3pin/molex3pin.scad>

module splitMidPanel2_cornerHoles(w=230, h=170) {
    translate([0,0,2.6])
        rectCycle([w-(5+2.6)*2,170-5*2], center=true)
            mirror([0,0,1])
                m3FHCS_counterSinkCutout(2.6);
}

module splitMidPanel2_molexCycle(w=230, h=170) {
    translate([w/2-5-2.6,h/2-35,2.6])
        mirror([0,0,1])
            rotate([0,0,90])
                children();

    translate([w/2-5-2.6,0,2.6])
        mirror([0,0,1])
            rotate([0,0,90])
                children();

    translate([w/2-5-2.6,h/-2+35,2.6])
        mirror([0,0,1])
            rotate([0,0,90])
                children();
    
    translate([w/-2+5+2.6,h/2-35,2.6])
        mirror([0,0,1])
            rotate([0,0,-90])
                children();

    translate([w/-2+5+2.6,0,2.6])
        mirror([0,0,1])
            rotate([0,0,-90])
                children();

    translate([w/-2+5+2.6,h/-2+35,2.6])
        mirror([0,0,1])
            rotate([0,0,-90])
                children();
}

function splitMidPanel2_points(w=230,h=170) = [
    [w/-2,h/2],
    [-75.5,h/2],
    [-74.5,h/2-2.6],
    [-45.5,h/2-2.6],
    [-44.5,h/2],
    [w/2,h/2],
    [w/2,h/-2],
    [w/-2,h/-2]
];

module splitMidPanel2_singlePiece(w=230, h=170) {
    difference() {
        union() {
            // Bottom fill-in layer.
            linear_extrude(0.4)
                polygon(splitMidPanel2_points());

            // Full height hexes.
            hex_panel(splitMidPanel2_points(), height=2.6, strut=3, spacing=(213-13*2)/12, frame = 3, anchor=BOTTOM);

            // Mini hexes.
            hex_panel(splitMidPanel2_points(), height=0.8, strut=1.5, spacing=(213-13*2)/36, frame = 3, anchor=BOTTOM);
            
            // Center.
            cube([59+15*2,h,2.6], anchor=BOTTOM);
            
            // Corner screw bosses.
            rectCycle([w-(5+2.6)*2,170-5*2], center=true)
                cylinder(h=2.6, d=10, $fn=20);
            
            // Molex bosses.
            splitMidPanel2_molexCycle()
                linear_extrude(2.6)
                    rect([33,10], rounding=5);
            
            // Roundover for the ribbon cutout.
            translate([-75.5,h/2-2.6,2.6/2])
                rotate([0,90,0])
                    cylinder(h=32,d=2.6,$fn=20);
        }
    
        splitMidPanel2_cornerHoles();
        
        splitMidPanel2_molexCycle()
            molex3pin_portPanelCutout();
        
        translate([-69/2,h/-2,0])
            linear_extrude(2.61)
                m3_mountingHoleColumn(10, 6, 30);

        translate([69/2,h/-2,0])
            linear_extrude(2.61)
                m3_mountingHoleColumn(10, 6, 30);
    }
}

module splitMidPanel2_centerCutout(w=230,h=170) {
    translate([0,0,2.6/2])
        cube([59+15*2,h+0.1,2.6/2], anchor=BOTTOM);
    
    cube([59,h,2.6], anchor=BOTTOM);
}

module splitMidPanel2_topCutout(w=230,h=170) {
    cube([w,h/2,2.6], anchor=BOTTOM+FRONT);
}

module splitMidPanel2_bottomCutout(w=230,h=170) {
    cube([w,h/2,2.6], anchor=BOTTOM+BACK);
}

module splitMidPanel2_center() {
    intersection() {
        splitMidPanel2_singlePiece();
        splitMidPanel2_centerCutout();
    }
}

module splitMidPanel2_centerTop() {
    intersection() {
        splitMidPanel2_singlePiece();
        splitMidPanel2_centerCutout();
        splitMidPanel2_topCutout();
    }
}

module splitMidPanel2_centerBottom() {
    intersection() {
        splitMidPanel2_singlePiece();
        splitMidPanel2_centerCutout();
        splitMidPanel2_bottomCutout();
    }
}

module splitMidPanel2_leftTop() {
    intersection() {
        difference() {
            splitMidPanel2_singlePiece();
            splitMidPanel2_centerCutout();
        }
        
        cube([230/2,170/2,2.6], anchor=BOTTOM+FRONT+RIGHT);
    }
}

module splitMidPanel2_leftBottom() {
    intersection() {
        difference() {
            splitMidPanel2_singlePiece();
            splitMidPanel2_centerCutout();
        }
        
        cube([230/2,170/2,2.6], anchor=BOTTOM+BACK+RIGHT);
    }
}

module splitMidPanel2_rightTop() {
    intersection() {
        difference() {
            splitMidPanel2_singlePiece();
            splitMidPanel2_centerCutout();
        }
        
        cube([230/2,170/2,2.6], anchor=BOTTOM+FRONT+LEFT);
    }
}

module splitMidPanel2_rightBottom() {
    intersection() {
        difference() {
            splitMidPanel2_singlePiece();
            splitMidPanel2_centerCutout();
        }
        
        cube([230/2,170/2,2.6], anchor=BOTTOM+BACK+LEFT);
    }
}
