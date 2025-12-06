module circleRepeat(radius, angles=[]) {
    for (theta=angles)
        translate(polar_to_xy(radius,theta))
            children();
}