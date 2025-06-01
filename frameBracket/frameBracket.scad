include <../m3/m3.scad>
include <../cubes/cubes.scad>

module frameBracket_outline() {
    polygon([
        [0,0],
        [12,12],
        [14,12],
        [26,0],
        [26,-2],
        [0,-2]
    ]);
}

module frameBracket_emboss() {
    hull() {
        translate([0,0,1.2])
            linear_extrude(0.1)
                offset(delta=-2.6)
                    frameBracket_outline();
        
        linear_extrude(0.1)
            offset(delta=-4)
                frameBracket_outline();
    }
}

module frameBracket(embossTop=true, embossBottom=true) {
    union() {
        difference() {
            linear_extrude(15)
                frameBracket_outline();
                
            translate([12,0,15/2])
                rotate([-90,0,45])
                    translate([0,0,-10+2])
            m3BHCS_counterSinkCutout(16.5, 16.5-4);
            

            translate([21,11,15/2])
                rotate([90,0,0])
                    m3BHCS_counterSinkCutout(14, 9);
            
            if (embossTop) {
                translate([0,0,15-1.2])
                    frameBracket_emboss();
            }
            
            if (embossBottom) {
                translate([0,0,1.2])
                    mirror([0,0,1])
                        frameBracket_emboss();
            }
        }
        
        rotate([0,0,45])
            translate([15/2+1,0,15/2]) {
                translate([0,0,15/2-2.6/2])
                    rotate([-90,0,0])
                        beveledCube([2.6,2.6],0.4,1);
                    
                translate([-15/2+2.6/2,0,0])
                    rotate([-90,0,0])
                        beveledCube([2.6,2.6],0.4,1);
                    
                translate([0,0,-15/2+2.6/2])
                    rotate([-90,0,0])
                        beveledCube([2.6,2.6],0.4,1);
                    
                translate([15/2-2.6/2,0,0])
                    rotate([-90,0,0])
                        beveledCube([2.6,2.6],0.4,1);
            }
            
        translate([8/2+1,-2,15/2])
            rotate([90,0,0])
                beveledCube([8,3],0.4,1);
    }
}

module frameBracket_magnetPocket(h=3.2, d=6.2) {
    union() {
        translate([d/2,d/2+d/10,0])
        cylinder(h=h,d=d, $fn=25);
        
        cube([d, d/2+d/10, h]);
    }
}

module frameBracket_withMagnets(h=3.2, d=6.2) {
    difference() {
        frameBracket(embossBottom=false);

        translate([14,-2,0.6])
            frameBracket_magnetPocket(h=h,d=d);
        
        translate([6,-2,0.6])
            frameBracket_magnetPocket(h=h,d=d);
    }
}
