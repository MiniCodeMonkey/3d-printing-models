echoDiameter = 83.5;
echoRadius = echoDiameter / 2;

standHeight = 22;
bottomThickness = 4;

enclosureThickness = 2;

powerCableThickness = 9.3;

$fn = 500;

module standBaseOutside() {
    difference() {
        cylinder(h = standHeight, r1 = echoRadius * 1.5, r2 = echoRadius);
        
        // To "cut the hole"
        translate([0, -echoRadius * 1.48, 12])
        translate([-(18.3 / 2), -20, -(12.25 / 2)])
        cube([18.3, 26 + 20, 12.25]);
    }
}

module standBaseInside() {
    translate([0, 0, bottomThickness])
    cylinder(h = standHeight * 2, r = echoRadius);
}

module standBase() {
    difference() {
        standBaseOutside();
        standBaseInside();
    }
}

module audioJackInside() {
    rotate([90, 0, 0])
    cylinder(h = 9, r = 4.62);

    translate([-(18.3 / 2), 0, -(12.25 / 2)])
    cube([18.3, 26, 12.25]);
}

module audioJackEnclosure() {
    translate([-((18.3 + (enclosureThickness * 2))  / 2), -9, -((12.25 + (enclosureThickness * 2)) / 2)])
    cube([18.3 + (enclosureThickness * 2), 26 + 9, 12.25 + (enclosureThickness * 2)]);
}

module audioJack() {
    difference() {
        translate([0, -echoRadius * 1.59, 12])
        difference() {
            audioJackEnclosure();
            audioJackInside();
        }
        
        standBaseInside();
    }
}

module powerCablehole() {
    radius = powerCableThickness / 2;
    
    rotate([90, 0, 0])
    translate([0, bottomThickness + radius, -80])
    cylinder(h = 50, r = radius);
}


difference() {
    standBase();
    powerCablehole();
}

audioJack();