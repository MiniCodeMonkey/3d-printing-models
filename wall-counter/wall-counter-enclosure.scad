displayWidth = 120;
displayHeight = 41;
displayDepth = 5;
displaySpacing = 6;

enclosureInsideWidth = (displayWidth * 2) + displaySpacing;
enclosureInsideHeight = displayHeight + 15;
enclosureInsideDepth = 25;
enclosureThickness = 3;
enclosureRoundedCornerRadius = 2;

enclosureOutsideWidth = enclosureInsideWidth + (enclosureThickness * 2);
enclosureOutsideDepth = enclosureInsideDepth + (enclosureThickness * 2);
enclosureOutsideHeight = enclosureInsideHeight + (enclosureThickness * 2);

centerHoleRadius = enclosureInsideDepth / 3;

cableHoleRadius = 5.5;

$fn = 1000;

module sevenSegDisplay() {
	cube([displayWidth, displayDepth, displayHeight]);
}

module combinedSevenSegDisplay() {
	sevenSegDisplay();
	translate([displayWidth + displaySpacing, 0, 0])
	sevenSegDisplay();
}

module roundedEdge() {
	rotate([90, 0, 0])
	translate([0, enclosureOutsideHeight / 2 - enclosureThickness, -enclosureOutsideDepth / 2 + enclosureThickness])
	cylinder(h = enclosureOutsideDepth, d=enclosureOutsideHeight, center = true);
}

module enclosure() {
	union() {
		difference() {
			union() {
				// Outside
				translate([-enclosureThickness, -enclosureThickness, -enclosureThickness])
				cube([enclosureOutsideWidth, enclosureOutsideDepth, enclosureOutsideHeight]);

				// Left rounded edge
				roundedEdge();

				// Right rounded edge
				translate([enclosureOutsideWidth, 0, 0])
				roundedEdge();
			}
			
			// Inside
			cube([enclosureInsideWidth, enclosureInsideDepth, enclosureInsideHeight]);
		}

		translate([0, -enclosureThickness , 0])
		cube([enclosureInsideWidth, displayDepth, enclosureInsideHeight]);
	}
}

module centerSupport() {
	translate([enclosureInsideWidth / 2 - displaySpacing / 2, 0, -enclosureThickness])
	cube([displaySpacing, enclosureInsideDepth, enclosureOutsideHeight]);
}

module centerHole() {
	cylinderHeight = 20;

	union() {
		// Cable hole
		translate([enclosureInsideWidth / 2 - cylinderHeight / 2, enclosureInsideDepth / 2, enclosureInsideHeight / 2])
		rotate([0, 90, 0])
		cylinder(h = cylinderHeight, r = centerHoleRadius);

		translate([enclosureInsideWidth / 2 - cylinderHeight / 2, enclosureInsideDepth / 2, enclosureInsideHeight / 2 - centerHoleRadius])
		cube(size = centerHoleRadius * 2);

		// Bottom connector hole
		translate([enclosureInsideWidth / 2 - cylinderHeight / 2, enclosureInsideDepth / 2, enclosureInsideHeight / 4 - 5])
		rotate([0, 90, 0])
		cylinder(h = cylinderHeight, r = 2.5);

		// Top connector hole
		translate([enclosureInsideWidth / 2 - cylinderHeight / 2, enclosureInsideDepth / 2, enclosureInsideHeight / 2 + enclosureInsideHeight / 4 + 5])
		rotate([0, 90, 0])
		cylinder(h = cylinderHeight, r = 2.5);
	}
}

module cableHole() {
	cylinderHeight = 20;

	translate([enclosureInsideWidth - cylinderHeight / 2, enclosureInsideDepth / 2, enclosureInsideHeight / 4])
	rotate([0, 90, 0])
	cylinder(h = cylinderHeight, r = cableHoleRadius);
}

module entireClosure() {
	difference() {
		difference() {
			difference() {
				union() {
					enclosure();
					centerSupport();
				}

				translate([0, -(displayDepth * 2.5), enclosureInsideHeight / 2 - displayHeight / 2])
				scale([1, 5, 1])
				combinedSevenSegDisplay();
			}
			centerHole();
		}
		cableHole();
	}
}

module enclosureBack() {
	union() {
		difference() {
			entireClosure();

			translate([-enclosureThickness - enclosureOutsideWidth / 2, -enclosureThickness * 2, -enclosureThickness - enclosureOutsideHeight / 2])
			cube([enclosureOutsideWidth * 2, enclosureOutsideDepth, enclosureOutsideHeight * 2]);
		}
	}
}

module enclosureFront() {
	difference() {
		entireClosure();

		translate([-enclosureThickness - enclosureOutsideWidth / 2, enclosureOutsideDepth - (enclosureThickness * 2), -enclosureThickness - enclosureOutsideHeight / 2])
		cube([enclosureOutsideWidth * 2, enclosureOutsideDepth, enclosureOutsideHeight * 2]);
	}
}

explodeSpacing = 0;

module splitEnclosure() {
	enclosureBack();

	translate([0, -explodeSpacing, 0])
	enclosureFront();
}

module left() {
	difference() {
		splitEnclosure();

		translate([enclosureOutsideWidth / 2 - displaySpacing / 2, -explodeSpacing - (enclosureThickness * 2), -enclosureThickness])
		cube([enclosureOutsideWidth, enclosureOutsideDepth * 4, enclosureOutsideHeight * 2]);
	}
}

module right() {
	difference() {
		splitEnclosure();

		translate([- enclosureOutsideWidth / 2 - displaySpacing / 2, -explodeSpacing - (enclosureThickness * 2), -enclosureThickness])
		cube([enclosureOutsideWidth, enclosureOutsideDepth * 4, enclosureOutsideHeight * 2]);
	}
}

left();

translate([explodeSpacing * 2, 0, 0])
right();