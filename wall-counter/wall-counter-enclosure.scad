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

railHeight = 1.5;
railWidth = railHeight * 2;

snapGuideThickness = 1.5;

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

module enclosure() {
	union() {
		difference() {
			// Outside
			minkowski() {
				translate([-enclosureThickness, -enclosureThickness, -enclosureThickness])
				cube([enclosureOutsideWidth, enclosureOutsideDepth, enclosureOutsideHeight]);
				
				cylinder(r = enclosureRoundedCornerRadius);
			}
			
			// Inside
			cube([enclosureInsideWidth, enclosureInsideDepth, enclosureInsideHeight]);
		}

		translate([0, -displayDepth, 0])
		cube([enclosureInsideWidth, displayDepth, enclosureInsideHeight]);
	}
}

module labelRail() {
	union() {
		// Horizontal
		translate([-enclosureOutsideWidth / 2, -enclosureThickness, -enclosureThickness / 2])
		cube([enclosureOutsideWidth * 2, railWidth, railHeight]);

		// Vertical
		translate([-enclosureOutsideWidth / 2, -enclosureThickness + (railWidth / 2), -enclosureThickness / 2 - railWidth])
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
				difference() {
					union() {
						enclosure();
						centerSupport();
					}

					translate([0, -(displayDepth * 2.5), enclosureInsideHeight / 2 - displayHeight / 2])
					scale([1, 5, 1])
					combinedSevenSegDisplay();
				}
				labelRail();
			}
			//centerHole();
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

		scale([1, 1, 1]) // For a better fit
		snapGuide();

		translate([enclosureOutsideWidth / 2 + displaySpacing / 2, 0, 0])
		scale([1, 1, 1]) // For a better fit
		snapGuide();
	}
}

module enclosureFront() {
	difference() {
		entireClosure();

		translate([-enclosureThickness - enclosureOutsideWidth / 2, enclosureOutsideDepth - (enclosureThickness * 2), -enclosureThickness - enclosureOutsideHeight / 2])
		cube([enclosureOutsideWidth * 2, enclosureOutsideDepth, enclosureOutsideHeight * 2]);
	}
}

module snapGuide() {
	spacingDelta = 0.3;

	difference() {
		// Outside
		translate([
			spacingDelta,
			enclosureInsideDepth - (enclosureInsideDepth / 5),
			spacingDelta
		])
		cube([
			(enclosureInsideWidth / 2) - (displaySpacing / 2) - (spacingDelta * 2),
			enclosureInsideDepth / 5,
			enclosureInsideHeight - (spacingDelta * 2)
		]);

		// Inside
		translate([
			snapGuideThickness + spacingDelta,
			enclosureInsideDepth - (enclosureInsideDepth / 5),
			snapGuideThickness + spacingDelta
		])
		cube([
			(enclosureInsideWidth / 2) - (displaySpacing / 2) - (snapGuideThickness * 2)  - (spacingDelta * 2),
			(enclosureInsideDepth / 5),
			enclosureInsideHeight - (snapGuideThickness * 2) - (spacingDelta * 2)
		]);
	}
}

explodeSpacing = 50;

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

module logo() {
    rotate([90, 0, 0])
    scale([0.4, 0.4, 0.4])
    linear_extrude(height = 7, center = true, convexity = 1000, twist = 0)
    import("logo.dxf");
}

module labelText() {
	linear_extrude(height = 2) {
		text("Marketplace Clips", font = "Liberation Sans", size = 10);
	};
}

module labelSign() {
	height = enclosureOutsideHeight * 0.8;

	union() {
		// Horizontal bar
		translate([-explodeSpacing, -explodeSpacing - railHeight, -railHeight + 0.5])
		cube([enclosureOutsideWidth / 2, railWidth, railHeight]);

		// Main area
		translate([-explodeSpacing, -explodeSpacing, -height + 0.5])
		cube([enclosureOutsideWidth / 2, railHeight, height]);
	}

	translate([-explodeSpacing + 5, -explodeSpacing, -20])
	logo();

	translate([-explodeSpacing + 5, -explodeSpacing, -35])
	rotate([90, 0, 0]) labelText();
}

translate([-enclosureThickness - 2, 0, 0])
scale([0.90, 0.90, 0.90]) // For a better fit
labelSign();

left();

translate([explodeSpacing * 2, 0, 0])
right();