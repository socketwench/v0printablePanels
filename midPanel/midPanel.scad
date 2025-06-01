include <../m3/m3.scad>

module midPanel_MountingTabOutline() {
    hull() {
        translate([1.5,0])
            // The -0.4 is twice our easement because the square is centered,
            // But it doesn't matter because we're using hull() here.
            square([12-0.4,15], center=true);        
        
        translate([7.5,6.5])
            circle(d=2, $fn=50);
        
        polygon([
            [7.5,6.5],
            [7.5,-7.5],
            [20,-7.5]
        ]);
    }
}

module midPanel_MountingTab() {
    linear_extrude(2.6) 
        difference() {
            midPanel_MountingTabOutline();
            m3_mountingHole();
        }
}

module midPanel_holes(mountHoleCenterlineX=15+58+(15/2)) {
    translate([mountHoleCenterlineX,0]) 
        m3_mountingHoleColumn(holeInset, holeCountPerColumn, holeSpacing);
    translate([midPanelX-mountHoleCenterlineX,0]) 
        m3_mountingHoleColumn(holeInset, holeCountPerColumn, holeSpacing);
}

module midPanel_zBeltCutout() {
    let(midPanelX=230, midPanelY=170) {
        // Belted Z cutout.
        // The cut diagram says X=83, and Y=15.
        // The actual part is 80 and 13.8.
        // So we size it for the part and tolerence.
        translate([midPanelX/2,14/2]){
            square([80.4,14], center=true);
        }
    }
}

module midPanel_Outline(midPanelX=230, midPanelY=170) {
    difference() {
        polygon([
            [0,0],
            [0,midPanelY],

            [midPanelX,midPanelY],
            [midPanelX,0]
        ]);
        midPanel_holes();
        
        midPanel_zBeltCutout();
    }
}

module midPanel() {
    linear_extrude(2.6)
        midPanel_Outline();
}