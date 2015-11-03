sizeFactor = 1.10; // My printer's print dimensions are about 10% smaller on average

cupHolderDiameter = 74;
cupHolderDepth = 52;
standAngle = -15;
standDepth = 15;
standHeight = 70;
phoneHolderThickness = 2;
standWidth = 83 + (phoneHolderThickness * 2);

// Cup holder
module cupHolder() {
    difference() {
        difference()
        {
            wallWidth = 3;
            
            // Outer shell
            translate([0,0,0])
            cylinder(h = cupHolderDepth, r1 = cupHolderDiameter / 3, r2 = cupHolderDiameter / 2, $fn = 300);
            
            difference() {
            // Inner shell
            translate([0, 0, -wallWidth])
            cylinder(h = cupHolderDepth - wallWidth, r1 = (cupHolderDiameter / 3) - wallWidth, r2 = (cupHolderDiameter / 2) - wallWidth, $fn = 400);
            }
        }

        // Outer holder
        translate([-(standWidth / 2), -20, cupHolderDepth])
        rotate([standAngle, 0, 0])
        cube([standWidth, 20, standHeight], false);
    }
}

module phoneHolder() {
    // Phone holder
    difference() {
        minkowski() {
            // Outer holder
            translate([-(standWidth / 2), -standDepth, cupHolderDepth])
            rotate([standAngle, 0, 0])
            cube([standWidth, standDepth, standHeight], false);
            
            sphere(r = 1, $fn = 100);
        }
        
        // Inner holder
        translate([-(standWidth / 2) + phoneHolderThickness, -standDepth - phoneHolderThickness, cupHolderDepth + (phoneHolderThickness * 2)])
        rotate([standAngle, 0, 0])
        cube([standWidth - (phoneHolderThickness * 2), standDepth, standHeight], false);
    }
    
    // Side holders
    sideHolderWidth = 6;
    
    translate([-(standWidth / 2) + phoneHolderThickness, -standDepth - (phoneHolderThickness / 2), cupHolderDepth])
    rotate([standAngle, 0, 0])
    cube([sideHolderWidth, phoneHolderThickness, standHeight / 2], false);
    
    translate([(standWidth / 2) - sideHolderWidth - phoneHolderThickness, -standDepth - (phoneHolderThickness / 2), cupHolderDepth])
    rotate([standAngle, 0, 0])
    cube([sideHolderWidth, phoneHolderThickness, standHeight / 2], false);
}

module chargerCableHole() {
    length = 26.3;
    width = 5.6;
    
    minkowski()
    {
        translate([-(length / 2), -18, cupHolderDepth / 2])
        rotate([standAngle, 0, 0])
        cube([length,width, 50]);
        
        sphere(r = 0.25, $fn = 100);
    }
}

module cableHole() {
    hull() {
        translate([0, cupHolderDiameter / 2, -6])
        rotate([2, 0, 0])
        cylinder(h = cupHolderDepth * 1.5, r = 6, center = false, $fn = 200);
        
        translate([0, (cupHolderDiameter / 2) - 15, -70])
        rotate([2, 0, 0])
        cylinder(h = cupHolderDepth, r = 6, center = false, $fn = 200);
    }
}

module logo() {
    translate([0, 8, 80])
    rotate([90 + standAngle, 0, 0])
    linear_extrude(height = 10, center = true, convexity = 1000, twist = 0)
    text(text = "MINI", font = "Raleway:style=ExtraBold", size = 14, valign = "center", halign = "center");
}


difference() {
    difference() {
        cupHolder();
        cableHole();
    }
    
    chargerCableHole();
}

difference() {
    difference() {
        phoneHolder();
        logo();
    }
    chargerCableHole();
}
