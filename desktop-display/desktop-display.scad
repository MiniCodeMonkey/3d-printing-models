pcbWidth = 38;
pcbHeight = 29;
pcbThickness = 2;

screenWidth = 25;
screenHeight = 14;
screenThickness = 10;

module sparkfunThingBoard() {
    width = 27;
    height = 58;
    thickness = 2;
    
    color("red")
    rotate([0, 90, 0])
    cube([width, height, thickness]);
}

module displayPCB() {
    color("black")
    rotate([90, 0, 0])
    cube([pcbWidth, pcbHeight, pcbThickness]);
}

module displayScreen() {    
    color("orange")
    rotate([90, 0, 0])
    translate([pcbWidth / 2 - screenWidth / 2, pcbHeight / 2 - screenHeight / 2, -screenThickness])
    cube([screenWidth, screenHeight, screenThickness]);
}

module enclosure() {
    insideWidth = 58;
    insideHeight = 29;
    insideDepth = 25;
    thickness = 2;
    
    difference() {
        rotate([0, 0, 90])
        translate([-thickness / 2, -thickness / 2, -thickness / 2])
        cube([insideWidth + thickness, insideDepth + thickness, insideHeight + thickness]);

        rotate([0, 0, 90])
        cube([insideWidth, insideDepth, insideHeight]);
    }
}

translate([-8, 0, 27 / 2 + 29 / 2])
sparkfunThingBoard();

//translate([0, 38 / 2 + 58 / 2, 0])
//rotate([0, 0, -90])
//displayPCB();

difference() {    
    enclosure();
    
    translate([-8, 38 / 2 + 58 / 2, 0])
    rotate([0, 0, -90])
    displayScreen();
}