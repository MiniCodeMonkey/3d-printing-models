include <roundedcube.scad>;

displayWidth = 64.8;
displayHeight = 48.6;
bezelSizeFactor = 1.45;
bezelDepth = 2;

module outerBezel() {
    roundedcube([displayWidth * bezelSizeFactor, bezelDepth, displayHeight * bezelSizeFactor], true, 0.9, "y");
}

module displayCutOut() {
    cube([displayWidth, bezelDepth * 5, displayHeight], center = true);
}

module finalBezel() {
    difference() {
        outerBezel();    
        displayCutOut();
    }
}

rotate([90, 0, 0])
    finalBezel();
