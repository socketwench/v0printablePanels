module beveledCube(size,bevel,height) {
    hull() {
        translate([0,0,height])
            linear_extrude(0.01)
                offset(delta=bevel*-1)
                    square(size, center=true);
        
        
        linear_extrude(0.01)
            square(size, center=true);
    }
}
