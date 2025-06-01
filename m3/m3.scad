module m3x5x4_ThreadedInsert() {
    cylinder(h=5,d=4.8,$fn=25);
}

module m3FHCS_counterSink() {
    cylinder(h=1.6, d1=3.8*2, d2=3.8, $fn=25);
}

module m3FHCS_counterSinkCutout(height=5) {
    union() {
        cylinder(h=1.6, d1=3.8*2, d2=3.8, $fn=25);
        cylinder(h=height+1.6, d=3.8, $fn=25);
    }
}

module m3BHCS_counterSinkCutout(height=5, countsinkHeight=1.6) {
    union() {
        cylinder(countsinkHeight, d=6, $fn=25);
        cylinder(h=height, d=3.8, $fn=25);
    }
}

module m3_mountingHole() {
    hull() {
        translate([-1.5,0])
            circle(d=3.8, $fn=25);
        translate([1.5,0]) 
            circle(d=3.8, $fn=25);
    }
}

module m3_mountingHoleColumn(holeInset, holeCountPerColumn, holeSpacing) {
    union () {
        translate([0,holeInset,0]) {
            for (i = [0:1:holeCountPerColumn-1]) {
                translate([0,i*holeSpacing]) 
                    m3_mountingHole();
            }
        }
    }
}
