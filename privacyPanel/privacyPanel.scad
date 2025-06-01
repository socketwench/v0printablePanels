include <../m3/m3.scad>
include <../hexagons/hexagons.scad>
include <../cubes/cubes.scad>

module privacyPanel_MountingTabOutline() {
    hull() {
        square([15,15], center=true);
        
        translate([7.5,6.5])
            circle(d=2, $fn=50);
        
        polygon([
            [7.5,6.5],
            [7.5,-7.5],
            [15,-7.5]
        ]);
    }
}

module privacyPanelMountingTab() {
    linear_extrude(2.6) 
        difference() {
            privacyPanel_MountingTabOutline();
            
            rotate([0,0,90])
                m3_mountingHole();
        }
}

module privacyPanel_left(privacyPanelX=34, privacyPanelY=170) {
    mirror([1,0,0])
        privacyPanel_right();
}

module privacyPanel_right(privacyPanelX=34, privacyPanelY=170) {
    union() {
        difference() {
            cube([privacyPanelX,privacyPanelY,2.6]);
            
            translate([4,8,0])
                beveledHexagonPanel(22,2,3,privacyPanelX-8, privacyPanelY-16,1.2, 0, 11);
            
            translate([privacyPanelX-5,privacyPanelY-5,0])
                m3FHCS_counterSinkCutout(2.6);
            
            translate([privacyPanelX-5,5,0])
                m3FHCS_counterSinkCutout(2.6);
        }
        
        /*  
        translate([privacyPanelX-7.5,0,7.5])
            rotate([90,0,180])
                privacyPanelMountingTab();
        
        translate([privacyPanelX-7.5,privacyPanelY-3,7.5])
            rotate([90,0,180])
                privacyPanelMountingTab();
        */
    }
}

module privacyPanel_bracketOutline() {
    polygon([
        [0,2],
        [0,34],
        [3,34],
        [3,26],
        [26,10],
        [34,10],
        [34,0],
        [2,0]
    ]);
}

module privacyPanel_bracketB() {
    let(bracketZ=15-2.6-0.2*2, privacyPanelX=34) {
        difference() {
            union() {
                linear_extrude(bracketZ)
                    privacyPanel_bracketOutline();
                
                translate([4+15/2,0,bracketZ/2-1.3])
                    rotate([90,0,0])
    beveledCube([15,2.6],0.4,0.4);
                
                translate([0,4/2+privacyPanelX/2,bracketZ/2-1.3])
                    
rotate([-90,0,90])
    beveledCube([15,2.6],0.4,0.4);
            }
            
            translate([5,5,0])
                m3x5x4_ThreadedInsert();
            
            translate([privacyPanelX-5,5,bracketZ/2-1.3])
                rotate([0,90,0])
                    m3x5x4_ThreadedInsert();
            
            translate([3,30,bracketZ/2-1.3])
                rotate([0,-90,0])
                    m3BHCS_counterSinkCutout(3,0.2);
        
            translate([26-3.8,34,bracketZ/2-1.3])
                rotate([0,-90,90])
                    m3BHCS_counterSinkCutout(34,34-3-.2);
        }
    }
}

module privacyPanel_bracketA() {
    let(bracketZ=15-2.6-0.2*2) {
        translate([0,0,bracketZ])
            mirror([0,0,1])
                privacyPanel_bracketB();
    }
}
