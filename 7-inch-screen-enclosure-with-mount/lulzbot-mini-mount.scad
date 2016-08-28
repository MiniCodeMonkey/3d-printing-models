lulzbotHoleDistance = 9.6;
caseHoleDistance = 15;
mountThickness = 4;
boltDiameter = 4.75;
mountWidth = 30;

$fn = 250;

module boltCutout() {
    cylinder(20, d = boltDiameter, center = true);
}

module lulzbotHoles() {
    translate([-lulzbotHoleDistance, 0, 0])
    boltCutout();

    boltCutout();
}

module screenHoles() {
    translate([0, -caseHoleDistance / 2, 0])
    boltCutout();

    translate([0, caseHoleDistance / 2, 0])
    boltCutout();
}

module printerSide() {
    difference() {
        cube([60, mountWidth, mountThickness], center = true);
        
        translate([-10, 0, 0])
        lulzbotHoles();
    }
}

module screenSide() {
    translate([50, 0, 12])
    rotate([0, -30, 0])
    difference() {
        cube([50, mountWidth, mountThickness], center = true);
        
        translate([21, 0, 0])
        screenHoles();
    }
}

union() {
    printerSide();
    screenSide();
}