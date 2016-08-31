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
        cube([40, mountWidth, mountThickness], center = true);
        
        translate([-3, 0, 0])
        lulzbotHoles();
    }
}

module screenSide() {
    translate([36.3, 0, 9.69])
    rotate([0, -30, 0])
    difference() {
        cube([40, mountWidth, mountThickness], center = true);
        
        translate([15.5, 0, 0])
        screenHoles();
    }
}

module fullMount() {
    printerSide();
    screenSide();
}

rotate([90, 0, 0])
fullMount();