laptopWidth = 18.5;

standRadius = 70;
standThickness = 7;
standHeight = 33;
curveAngle = 20;
cableHolderRadius = 6;


// Global $fn setting
$fn = 1000;

module outerCircle() {
    cylinder(h = standHeight, r = standRadius, center = true);
}

module innerCircle() {
    translate([0, 0, -standHeight]);
    cylinder(h = standHeight * 2, r = standRadius - (standThickness * 2), center = true);
}

module laptopCutOut() {
    translate([0, 0, (standHeight * 0.1)])
    cube([standRadius * 2, laptopWidth, standHeight * 0.9], center = true);
}

module circleCurveDown() {
    rotate([curveAngle, 0, 0])
    translate([0, 0, 35])
    outerCircle();
    
    rotate([-curveAngle, 0, 0])
    translate([0, 0, 35])
    outerCircle();
}

module logo() {
    rotate([90, 0, 0])
    translate([-22, -14, 66])
    scale([0.25, 0.25, 0.25])
    linear_extrude(height = 50, center = true, convexity = 1000, twist = 0)
    import("logo.dxf");
}

module cableHolder() {
    margin = 3;
    translate([0, cableHolderRadius * 4, cableHolderRadius - standHeight / 2 - margin])
    rotate([0, 90, 0])
    cylinder(h = standRadius * 2, r = cableHolderRadius, center = true);
    
    translate([0, cableHolderRadius * 4, cableHolderRadius - standHeight / 2 - cableHolderRadius - margin])
    cube([standRadius * 2, cableHolderRadius * 2, cableHolderRadius  * 2], center = true);
}

difference() {
    difference() {
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

        logo();
    }

    cableHolder();
}