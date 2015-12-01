module sparkfunThingBoard() {
    width = 27;
    height = 58;
    thickness = 2;
    
    color("red")
    cube([width, height, thickness]);
}

module display() {
    pcbWidth = 38;
    pcbHeight = 29;
    pcbThickness = 2;
    
    screenWidth = 25;
    screenHeight = 14;
    screenThickness = 1;
    
    color("black")
    cube([pcbWidth, pcbHeight, pcbThickness]);
    
    color("orange")
    translate([pcbWidth / 2 - screenWidth / 2, pcbHeight / 2 - screenHeight / 2, pcbThickness])
    cube([screenWidth, screenHeight, screenThickness]);
}


module insideComponents() {
    sparkfunThingBoard();

    translate([0, 38 / 2 + 58 / 2, 5])
    rotate([0, 0, -90])
    display();
}

translate([0, 0, 27])
rotate([0, 90, 0])
insideComponents();