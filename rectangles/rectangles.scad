module rectCycle(size, center=false) {
    let(w=size[0], h=size[1]) {
        translate([center ? w/-2 : 0, center ? h/-2 : 0]) {
            for(x=[0:1:1]) {
                for(y=[0:1:1]) {
                    translate([x*w,y*h])
                        children();
                }
            }
        }
    }
}
