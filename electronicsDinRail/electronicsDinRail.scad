include <../BOSL2/std.scad>
include <../BOSL2/screws.scad>

Height=48;

module electronicsDinRail_railCutout() {
    points = [
        [-35/2,7.5/2], 
        [-35/2,7.5/2-1.4],
        [-27.6/2-0.2,7.5/2-1.4], 
        [-27.6/2-0.2,7.5/2-1.4-6.4], 
        [27.6/2+0.2,7.5/2-1.4-6.4], 
        [27.6/2+0.2,7.5/2-1.4],
        [35/2,7.5/2-1.4],
        [35/2,7.5/2],
        [35/2-3.4-1.4-0.2,7.5/2],
        [35/2-3.4-1.4-0.2,7.5/2-6.4],
        [-35/2+3.4+1.4+0.2,7.5/2-6.4],
        [-35/2+3.4+1.4+0.2,7.5/2],
    ];

    polygon(points);

    translate([35/2,7.5/2-1.4/2])
        circle(d=2, $fn=15);
    
    translate([35/-2,7.5/2-1.4/2])
        circle(d=2, $fn=15);

    translate([27.6/2-1/2,7.5/2-1.4/2])
        circle(d=2.8, $fn=15);
    
    translate([27.6/-2+1/2,7.5/2-1.4/2])
        circle(d=2.8, $fn=15);
        
    translate([27.6/2-1.4/2,7.5/-2+1.4/2])
        circle(d=3, $fn=15);
    
    translate([27.6/-2+1.4/2,7.5/-2+1.4/2])
        circle(d=3, $fn=15);
}

module electronicsDinRail_baseOutline() {
    difference() {
        rect([42,Height], rounding=3, $fn=15);

        translate([42/2-6,Height/2-14/2])
            rect([3.8,7.5], rounding=3.8/2, $fn=15);

        translate([42/-2+6,Height/2-14/2])
            rect([3.8,7.5], rounding=3.8/2, $fn=15);

        rect([42-4*2,Height-14*2], rounding=3, $fn=15);
        
        translate([0,Height/-2+7])
            electronicsDinRail_railCutout();
    }
}

module electronicsDinRail_base() {
    difference() {
        linear_extrude(6)
            electronicsDinRail_baseOutline();

            translate([0,10,3])
                prismoid(size1=[42,48-14-5], size2=[42,48-14], h=3);
    }
}

module electronicsDinRail_dinHolder() {
    union() {
        translate([0,-1.5-2.8,0])
            rotate([90,0,0])
                diff()
                  prismoid(size1=[20.4,8], size2=[25.2,8], h=2.8, anchor=FRONT+BOTTOM)
                    attach(BOTTOM)
                        mirror([0,0,1])
                       screw_hole("M3",head="flat large",length=2.8,anchor=BOTTOM,$fn=15);

        diff()
            prismoid(size1=[17,3], size2=[10,3], h=8, anchor=BACK+BOTTOM)
                attach(FRONT)
                    screw_hole("M3,3",anchor=TOP,thread=true,bevel1="reverse");
    }
}

electronicsDinRail_base();

translate([0,-Height/2,6])
    rotate([0,0,180])
        electronicsDinRail_dinHolder();