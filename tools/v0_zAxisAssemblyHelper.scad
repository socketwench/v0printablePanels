module v0HelperShape() {
    polygon([
            [0,0],
            [0,15],
            [-15,15],
            [-15,25],
            [0,25],
            [0,40],
            [55,40],
            [55,40],
            [58,40],
            [58+2,40],
            [58+2,30],
            [58,30],
            [58,0],
        ]);
}


difference() {
    linear_extrude(5)
        v0HelperShape();

    linear_extrude(5)
        offset(delta=-10)
            v0HelperShape();
    
    translate([58/2,10/2,5-.8])
        linear_extrude(.8)
            text("58mm", size=7, halign="center", valign="center");
}
