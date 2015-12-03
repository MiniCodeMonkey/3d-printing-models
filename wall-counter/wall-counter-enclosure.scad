displayWidth = 120;
displayHeight = 41;
displayDepth = 5;
displaySpacing = 4;

enclosureInsideWidth = (displayWidth * 2) + displaySpacing;
enclosureInsideHeight = displayHeight * 1.1;
enclosureInsideDepth = 25;
enclosureThickness = 3;

enclosureOutsideWidth = enclosureInsideWidth + (enclosureThickness * 2);
enclosureOutsideDepth = enclosureInsideDepth + (enclosureThickness * 2);
enclosureOutsideHeight = enclosureInsideHeight + (enclosureThickness * 2);

railWidth = 4;
railHeight = 2;

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
		translate([-enclosureThickness, -enclosureThickness, -enclosureThickness])
		cube([enclosureOutsideWidth, enclosureOutsideDepth, enclosureOutsideHeight]);
		
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

module entireClosure() {
	difference() {
		difference() {
			union() {
				enclosure();
				labelRailSupport();
			}

			translate([0, -(displayDepth * 2.5), enclosureInsideHeight / 2 - displayHeight / 2])
			scale([1, 5, 1])
			combinedSevenSegDisplay();
		}
		labelRail();
	}
}

entireClosure();
