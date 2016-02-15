echoDiameter = 83.5;
echoRadius = echoDiameter / 2;

standHeight = 30;
bottomThickness = 4;

$fn = 1000;

module standBase() {
    difference() {
        cylinder(h = standHeight, r1 = echoRadius * 1.5, r2 = echoRadius);
        
        translate([0, 0, bottomThickness])
        cylinder(h = standHeight * 2, r = echoRadius);
    }
}

standBase();