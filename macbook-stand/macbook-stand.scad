laptopWidth = 19.25; // 19.25mm is for a retina Macbook Pro

standRadius = 70;
standThickness = 7;
standHeight = 23;
curveAngle = 20;

module outerCircle() {
    cylinder(h = standHeight, r = standRadius, center = true, $fn = 1000);
}

module innerCircle() {
    translate([0, 0, -standHeight]);
    cylinder(h = standHeight * 2, r = standRadius - (standThickness * 2), center = true, $fn = 1000);
}

module laptopCutOut() {
    translate([0, 0, (standHeight * 0.1)])
    cube([standRadius * 2, laptopWidth, standHeight * 0.9], center = true);
}

module circleCurveDown() {
    rotate([curveAngle, 0, 0])
    translate([0, 0, 25])
    outerCircle();
    
    rotate([-curveAngle, 0, 0])
    translate([0, 0, 25])
    outerCircle();
}

module logo() {
    rotate([curveAngle, 0, 0])
    translate([-22, -65, 14])
    scale([0.25, 0.25, 0.25])
    linear_extrude(height = 10, center = true, convexity = 1000, twist = 0)
    import("logo.dxf");
}

difference() {
    difference() {
        difference() {
            outerCircle();
            innerCircle();
        }

        laptopCutOut();
    }
    
    mirror([1, 0, 0])
    circleCurveDown();
}

// Comment this out if you don't want a logo embossed on the stand
logo();
