thickness = 3.9;

outerCircleDiameter = 22.9;
innerCircleDiameter = outerCircleDiameter - thickness;
circleGapWidth = 4.3;
spacerLength = 12.8 * 2;

$fs = 0.5;
$fa = 0.1;

module topCircleClosed() {
    difference() {
        cylinder(h = thickness, d = outerCircleDiameter);
        
        translate([0, 0, -thickness / 2])
        cylinder(h = thickness * 2, d = innerCircleDiameter);
    }
}

module topCircle() {
    difference() {
        topCircleClosed();
    
        translate([0, outerCircleDiameter / 2 - thickness / 2, thickness / 2])
        cube([circleGapWidth, circleGapWidth, thickness * 2], center = true);
    }
}

module hookSpacerStraight() {
    translate([-thickness / 4, -outerCircleDiameter / 2 + thickness / 2 - spacerLength, 0])
    cube([thickness / 2, spacerLength, thickness]);
}

module hookCircle() {
    difference() {
        translate([outerCircleDiameter / 2 - thickness / 4, -spacerLength - (outerCircleDiameter / 2) + 2, 0])
        cylinder(h = thickness, d = outerCircleDiameter);

        translate([outerCircleDiameter / 2 - thickness / 4, -spacerLength - (outerCircleDiameter / 2) + 2, - thickness / 2])
        cylinder(h = thickness * 2, d = innerCircleDiameter);
    }
}

module hookCutOut() {
    translate([thickness / 4, -spacerLength - (outerCircleDiameter / 2) + 2, - thickness / 2])
    cube([outerCircleDiameter, outerCircleDiameter / 2, thickness * 2]);
}

module hook() {
    difference() {
        hookCircle();
        hookCutOut();
    }
}

module hookFinisher() {
    translate([outerCircleDiameter - (thickness / 2) - 1, -outerCircleDiameter / 2 + thickness / 2 - spacerLength, 0])
    cube([thickness / 2, spacerLength / 3, thickness]);
}

module duktigHook() {
    topCircle();
    hookSpacerStraight();
    hook();
    hookFinisher();
}

duktigHook();
