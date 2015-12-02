mcuWidth = 27;
mcuHeight = 58;
mcuThickness = 2;

pcbWidth = 38;
pcbHeight = 29;
pcbThickness = 2;

screenWidth = 25;
screenHeight = 14;
screenThickness = 10;

enclosureInsideWidth = 15;
enclosureInsideHeight = mcuHeight * 1.2;
enclosureInsideDepth = pcbWidth;
enclosureThickness = 2;

cableDiameter = 5;

module sparkfunThingBoard() {    
    color("red")
    rotate([0, 90, 0])
    cube([mcuWidth, mcuHeight, mcuThickness], center = true);
}

module displayPCB() {
    color("black")
    rotate([90, 0, 0])
    cube([pcbWidth, pcbHeight, pcbThickness], center = true);
}

module displayScreen() {    
    color("orange")
    rotate([90, 0, 0])
    translate([0, 0, -screenThickness / 2])
    cube([screenWidth, screenHeight, screenThickness], center = true);
}

module enclosure() {    
    //color("transparent")
    translate([0, 0, -mcuHeight / 2 + pcbHeight / 2])
    
    difference() {
        cube([enclosureInsideWidth + enclosureThickness, enclosureInsideDepth + enclosureThickness, enclosureInsideHeight + enclosureThickness], center = true);
        
        cube([enclosureInsideWidth, enclosureInsideDepth, enclosureInsideHeight], center = true);
    }
}

module cableHole() {
    rotate([0, 90, 0])
    cylinder(h = 10, d = cableDiameter, center = true);
}

//rotate([90, 0, 0])
//translate([-5, -mcuHeight / 2 + 10, 0])
//sparkfunThingBoard();

//rotate([0, 0, -90])
//displayPCB();

module completeEnclosure() {
    difference() {
        difference() {
            translate([-5, 0, 0])
            enclosure();
            
            translate([-15, 0, -enclosureInsideHeight / 2])
            cableHole();
        }
        
        rotate([0, 0, -90])
        displayScreen();
    }
}

cutBlockDepth = (enclosureInsideDepth + enclosureThickness) / 2;
cutBlockWidth = (enclosureInsideWidth + enclosureThickness) * 2;
cutBlockHeight = (enclosureInsideHeight + enclosureThickness) * 2;

module leftSide() {
    difference() {
        completeEnclosure();
        
        translate([-cutBlockWidth / 2, 0, -cutBlockHeight / 2])
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

//leftSide();
rightSide();
