mcuWidth = 26.6;
mcuHeight = 55.55;
mcuThickness = 3.1;

screenPCBWidth = 35.5;
screenPCBHeight = 29.2;
screenPCBThickness = 5.3;

screenWidth = 25;
screenHeight = 16;
screenThickness = 10;

pcbSlotThickness = 1.5;

enclosureInsideWidth = 20;
enclosureInsideHeight = mcuHeight * 1.5;
enclosureInsideDepth = screenPCBWidth;
enclosureThickness = 2;
enclosureOffset = -5;

snapFitThickness = 1.5;
snapFitGapWidth = 2.5;

cableDiameter = 4;

enclosureZ = -mcuHeight / 2 + screenPCBHeight / 2;

rotaryEncoderDiamater = 6.9;

$fn = 1000;

module mcuPCB() {    
    color("red")
    
    translate([-8, 0, -(snapFitThickness / 2) + enclosureZ + enclosureInsideHeight / 2 - mcuHeight / 2])
    cube([mcuThickness, mcuWidth, mcuHeight], center = true);
}

module mcuPCBSlot() {
    difference() {
        difference() {
            difference() {
                translate([-8, 0, -(snapFitThickness / 2) + enclosureZ + enclosureInsideHeight / 2 - mcuHeight / 2 - pcbSlotThickness / 2])
                cube([mcuThickness + (pcbSlotThickness * 2), mcuWidth, mcuHeight + pcbSlotThickness], center = true);

                mcuPCB();
            }

            // Cut-out for USB power
            translate([-8, enclosureInsideDepth / 5, -(snapFitThickness / 2) + enclosureZ + enclosureInsideHeight / 2 - mcuHeight - 10 / 2])
            cube([mcuThickness, mcuWidth, 10], center = true);
        }

        // Center Cut-out
        translate([-8, 0, -(snapFitThickness / 2) + enclosureZ + enclosureInsideHeight / 2 - mcuHeight / 2 - pcbSlotThickness / 2])
        cube([mcuThickness + (pcbSlotThickness * 2), mcuWidth, (mcuHeight * 0.9) + pcbSlotThickness], center = true);
    }
}

module displayPCB() {
    color("black")
    rotate([90, 0, -90])
    translate([0, 0, 0])
    cube([screenPCBWidth, screenPCBHeight, screenPCBThickness], center = true);
}

module displayPCBSlot() {
    difference() {
        difference() {
            difference() {
                rotate([90, 0, -90])
                translate([0, 0, 0 + (pcbSlotThickness / 2)])
                cube([screenPCBWidth, screenPCBHeight + (pcbSlotThickness * 2), screenPCBThickness + pcbSlotThickness], center = true);

                displayPCB();
            }

            // Cable gap
            gapHeight = 4.9;
            rotate([90, 0, -90])
            translate([0, screenPCBHeight / 2 - gapHeight / 2, screenPCBThickness + (pcbSlotThickness / 2)])
            cube([screenPCBWidth, gapHeight, screenPCBThickness + pcbSlotThickness], center = true);
        }
        
        rotate([90, 0, -90])
        translate([0, 0, 0 + (pcbSlotThickness / 2)])
        cube([screenPCBWidth - (screenPCBThickness * 2), screenPCBHeight + (pcbSlotThickness * 2), screenPCBThickness + pcbSlotThickness], center = true);
    }
}

module displayScreen() {    
    color("orange")
    rotate([90, 0, -90])
    translate([0, (screenPCBHeight / 2) - (screenHeight / 2) - 5, -screenThickness / 2])
    cube([screenWidth, screenHeight, screenThickness], center = true);
}

module enclosure() {    
    translate([0, 0, enclosureZ])
    
    difference() {
        // Outside
        minkowski() {
            cube([enclosureInsideWidth + enclosureThickness, enclosureInsideDepth + enclosureThickness, enclosureInsideHeight + enclosureThickness], center = true);
            cylinder(r=1.5);
        }
        
        // Inside
        cube([enclosureInsideWidth, enclosureInsideDepth, enclosureInsideHeight], center = true);
    }
}

module cableHole() {
    translate([-15, 0, -enclosureInsideHeight / 2 - 7])
    rotate([0, 90, 0])
    cylinder(h = 10, d = cableDiameter, center = true);
}

module cableCubic() {
    translate([-12, 0, -enclosureInsideHeight / 2 - 7])
    rotate([0, 90, 0])
    cube([cableDiameter, cableDiameter * 2, cableDiameter * 2], center = true);
}

module completeEnclosure() {
    union() {
        difference() {
            difference() {
                translate([enclosureOffset, 0, 0])
                enclosure();
                
                cableHole();
            }
            
            displayScreen();
        }

        translate([1.9, 0, 0])
        displayPCBSlot();

        translate([0, -5, 0])
        mcuPCBSlot();
    }
}

cutBlockDepth = (enclosureInsideDepth + enclosureThickness) / 2;
cutBlockWidth = (enclosureInsideWidth + enclosureThickness) * 2;
cutBlockHeight = (enclosureInsideHeight + enclosureThickness) * 2;

module snapFit() {
    difference() {
        // Outside
        translate([enclosureOffset, 0, -mcuHeight / 2 + screenPCBHeight / 2])
        cube([enclosureInsideWidth, enclosureInsideDepth / 5, enclosureInsideHeight], center = true);
        
        // Inside
        color("yellow")
        translate([enclosureOffset, 0, -mcuHeight / 2 + screenPCBHeight / 2])
        cube([enclosureInsideWidth - snapFitThickness, (enclosureInsideDepth / 5) + snapFitThickness, enclosureInsideHeight - snapFitThickness], center = true);
    }
}

module leftSide() {
    difference() {
        completeEnclosure();
        
        translate([-cutBlockWidth / 2, 0, -cutBlockHeight / 2])
        cube([cutBlockWidth, cutBlockDepth * 2, cutBlockHeight]);
    }
    

    difference() {
        difference() {
            snapFit();
            displayScreen();
            cableCubic();
        }

        translate([-cutBlockWidth / 2, snapFitGapWidth, -cutBlockHeight / 2])
        cube([cutBlockWidth, cutBlockDepth * 2, cutBlockHeight]);
    }
}

module rightSide() {
    difference() {
        completeEnclosure();
        
        translate([-cutBlockWidth / 2, -cutBlockDepth * 2, -cutBlockHeight / 2])
        cube([cutBlockWidth, cutBlockDepth * 2, cutBlockHeight]);
    }
}

leftSide();
//rightSide();

//completeEnclosure();

