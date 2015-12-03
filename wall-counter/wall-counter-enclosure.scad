displayWidth = 120;
displayHeight = 41;
displayDepth = 5;
displaySpacing = 6;

enclosureInsideWidth = (displayWidth * 2) + displaySpacing;
enclosureInsideHeight = displayHeight * 1.2;
enclosureInsideDepth = 25;
enclosureThickness = 3;

enclosureOutsideWidth = enclosureInsideWidth + (enclosureThickness * 2);
enclosureOutsideDepth = enclosureInsideDepth + (enclosureThickness * 2);
enclosureOutsideHeight = enclosureInsideHeight + (enclosureThickness * 2);

railWidth = 4;
railHeight = 2;

centerHoleRadius = enclosureInsideDepth / 3;

$fn = 1000;

module sevenSegDisplay() {
	cube([displayWidth, displayDepth, displayHeight]);
}

module combinedSevenSegDisplay() {
	sevenSegDisplay();
	translate([displayWidth + displaySpacing, 0, 0])
	sevenSegDisplay();
}

module enclosure() {
	difference() {
		// Outside
		minkowski() {
			translate([-enclosureThickness, -enclosureThickness, -enclosureThickness])
			cube([enclosureOutsideWidth, enclosureOutsideDepth, enclosureOutsideHeight]);
			
			cylinder(r=5);
		}
		
		// Inside
		cube([enclosureInsideWidth, enclosureInsideDepth, enclosureInsideHeight]);
	}
}

module labelRail() {
	union() {
		// Horizontal
		translate([-enclosureOutsideWidth / 2, -enclosureThickness / 2, -enclosureThickness / 2])
		cube([enclosureOutsideWidth * 2, railWidth, railHeight]);

		// Vertical
		translate([-enclosureOutsideWidth / 2, -enclosureThickness / 2 + (railWidth / 4), -enclosureThickness / 2 - railWidth])
		cube([enclosureOutsideWidth * 2, railHeight, railWidth]);
	}
}

module labelRailSupport() {
	// Horizontal
	translate([-enclosureThickness, -enclosureThickness / 2, 0])
	cube([enclosureOutsideWidth, railWidth, railHeight]);
}

module centerSupport() {
	translate([enclosureInsideWidth / 2 - displaySpacing / 2, 0, -enclosureThickness])
	cube([displaySpacing, enclosureInsideDepth, enclosureOutsideHeight]);
}

module centerHole() {
	cylinderHeight = 20;

	translate([enclosureInsideWidth / 2 - cylinderHeight / 2, enclosureInsideDepth / 2, enclosureInsideHeight / 2])
	rotate([0, 90, 0])
	cylinder(h = cylinderHeight, r = centerHoleRadius);
}

module entireClosure() {
	difference() {
		difference() {
			difference() {
				union() {
					enclosure();
					centerSupport();
					labelRailSupport();
				}

				translate([0, -(displayDepth * 2.5), enclosureInsideHeight / 2 - displayHeight / 2])
				scale([1, 5, 1])
				combinedSevenSegDisplay();
			}
			labelRail();
		}

		centerHole();
	}
}

module enclosureBack() {
	difference() {
		entireClosure();

		//translate([-enclosureThickness - enclosureOutsideWidth / 2, -enclosureThickness * 2, -enclosureThickness - enclosureOutsideHeight / 2])
		//cube([enclosureOutsideWidth * 2, enclosureOutsideDepth, enclosureOutsideHeight * 2]);
	}
}

enclosureBack();