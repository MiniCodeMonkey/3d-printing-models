screenCutoutWidth = 156.5;
screenCutoutHeight = 89.2;

enclosureHeight = 126;
enclosureWidth = 165;
enclosureDepth = 15;
enclosureThickness = 2;

boltDiameter = 4.5;

$fn = 250;

module enclosure() {
    difference() {
        cube([enclosureWidth + (enclosureThickness * 2), enclosureDepth + (enclosureThickness * 2), enclosureHeight + (enclosureThickness * 2)], center = true);

        translate([0, enclosureDepth / 2, 0])
        cube([enclosureWidth, enclosureDepth * 2, enclosureHeight], center = true);
    }
}

module enclosureCutout() {
    translate([0, 0, 7])
    cube([screenCutoutWidth, enclosureDepth * 2, screenCutoutHeight], center = true);
}

module cablesCutout() {
    translate([enclosureWidth / 2, enclosureThickness / 2, enclosureHeight - screenCutoutHeight - enclosureThickness * 2])
    cube([20, enclosureDepth + enclosureThickness, 35], center = true);
}

module boltCutout() {
    cylinder(20, d = boltDiameter, center = true);
}

module assembleGuide() {
    difference() {
        translate([0, enclosureThickness / 2, -enclosureHeight / 2 + 8.3 / 2])
        cube([7, enclosureDepth + enclosureThickness, 8.3], center = true);
        
        translate([0, enclosureThickness / 2 + 8.3 / 2, -enclosureHeight / 2 + 8.3 / 2])
        rotate([0, 90, 0])
        boltCutout();
    }
}

module entireClosure() {
    difference() {
        enclosure();
        enclosureCutout();
        cablesCutout();

        translate([enclosureWidth / 2 - 15, 0, enclosureHeight / 2])
        boltCutout();

        translate([enclosureWidth / 2 - 30, 0, enclosureHeight / 2])
        boltCutout();
    }

    assembleGuide();

    translate([0, 0, enclosureHeight - 8.3])
    assembleGuide();
}

module leftPrint() {
    difference() {
        entireClosure();

        translate([-enclosureWidth / 2, 0, 0])
        cube([enclosureWidth, 200, 200], center = true);
    }
}

module rightPrint() {
    difference() {
        entireClosure();

        translate([enclosureWidth / 2, 0, 0])
        cube([enclosureWidth, 200, 200], center = true);
    }
}

leftPrint();
//rightPrint();