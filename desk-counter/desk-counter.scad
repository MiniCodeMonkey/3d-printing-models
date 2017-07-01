displayWidth = 120;
displayHeight = 41;
displayDepth = 5;
displayStandOffSpacing = 9.5;
displayStandOffHeight = 5;

enclosureInsideWidth = displayWidth;
enclosureInsideHeight = displayHeight + 15;
enclosureInsideDepth = 25;
enclosureThickness = 3;
enclosureRoundedCornerRadius = 2;

enclosureOutsideWidth = enclosureInsideWidth + (enclosureThickness * 2);
enclosureOutsideDepth = enclosureInsideDepth + (enclosureThickness * 2);
enclosureOutsideHeight = enclosureInsideHeight + (enclosureThickness * 2);

edgeSpacing = 5;

screwDiameter = 4.1;
screwStandOffDiameter = screwDiameter * 1.6;
screwLength = 12;

$fn = 100;

module sevenSegDisplay() {
	cube([displayWidth, displayDepth, displayHeight]);
}

module screwStandOff() {
	rotate([90, 0, 0])
	translate([0, 0, -enclosureOutsideDepth + enclosureThickness])
	difference() {
		cylinder(h = enclosureOutsideDepth, d = screwStandOffDiameter);
		cylinder(h = screwLength, d = screwDiameter);
	}

	rotate([90, 0, 0])
	translate([0, 0, -enclosureOutsideDepth])
	cylinder(h = screwLength, d = screwDiameter);
}

module roundedEdge(diff) {
	hull() {
		rotate([90, 0, 0])
		translate([0, enclosureOutsideHeight - enclosureThickness - enclosureOutsideHeight / 6, -enclosureOutsideDepth / 2 + enclosureThickness])
		cylinder(h = enclosureOutsideDepth, d=enclosureOutsideHeight / 3, center = true);

		rotate([90, 0, 0])
		translate([diff, enclosureOutsideHeight / 6 - enclosureThickness, -enclosureOutsideDepth / 2 + enclosureThickness])
		cylinder(h = enclosureOutsideDepth, d=enclosureOutsideHeight / 3, center = true);
	}
}

module outsideEnclosure() {
	hull() {
		// Outside
		translate([-enclosureThickness, -enclosureThickness, -enclosureThickness])
		cube([enclosureOutsideWidth, enclosureOutsideDepth, enclosureOutsideHeight]);

		// Left rounded edge
		roundedEdge(-edgeSpacing);

		// Right rounded edge
		translate([enclosureInsideWidth, 0, 0])
		roundedEdge(edgeSpacing);
	}
}

module insideEnclosure() {
	newScale = enclosureInsideWidth / enclosureOutsideWidth;
	insideScale = 1.0 - newScale;
	scale(newScale)
	translate([enclosureOutsideWidth * insideScale / 2, enclosureOutsideDepth * insideScale / 2, enclosureOutsideHeight * insideScale / 2])
	outsideEnclosure();
}

module displaySpacer() {
	translate([0, -2, 3])
	cube([displayWidth, displayStandOffSpacing, displayStandOffHeight]);
}

module enclosure() {
	difference() {
		outsideEnclosure();
		insideEnclosure();
	}

	displaySpacer();

	translate([0, 0, displayHeight + displayStandOffHeight - (enclosureThickness / 2)])
	displaySpacer();

	screwStandOffs();
}

module entireClosure() {
	difference() {
		enclosure();

		translate([0, -(displayDepth * 2.5), enclosureInsideHeight / 2 - displayHeight / 2])
		scale([1, 5, 1])
		sevenSegDisplay();
	}
}

module screwStandOffs() {
	difference() {
		union() {
			translate([-4, 0, 4])
			screwStandOff();

			translate([-4, 0, 45])
			screwStandOff();

			translate([4 + enclosureInsideWidth, 0, 4])
			screwStandOff();

			translate([4 + enclosureInsideWidth, 0, 45])
			screwStandOff();
		}

		translate([-enclosureThickness - (enclosureOutsideWidth * 0.25), enclosureInsideDepth - enclosureThickness, -enclosureThickness])
		cube([enclosureOutsideWidth * 1.5, enclosureThickness, enclosureOutsideHeight]);
	}
}

module enclosureFront() {
	difference() {
		entireClosure();

		translate([-enclosureThickness - enclosureOutsideWidth / 2, enclosureOutsideDepth - (enclosureThickness * 2), -enclosureThickness - enclosureOutsideHeight / 2])
		cube([enclosureOutsideWidth * 2, enclosureOutsideDepth, enclosureOutsideHeight * 2]);
	}
}

module cableHole() {
	hull() {
		rotate([90, 0, 0])
		translate([10, 10, -100])
		cylinder(h = 200, d = 10);

		rotate([90, 0, 0])
		translate([20, 10, -100])
		cylinder(h = 200, d = 10);
	}
}

module enclosureLid() {
	difference() {
		scale(0.988)
		//scale(1)
		insideEnclosure();

		translate([0, -enclosureThickness, 0])
		screwStandOffs();

		translate([-enclosureThickness - (enclosureOutsideWidth * 0.25), -enclosureThickness - 1, -enclosureThickness])
		cube([enclosureOutsideWidth * 1.5, enclosureOutsideDepth - enclosureThickness + 1, enclosureOutsideHeight]);

		cableHole();
	}
}

//enclosureFront();
enclosureLid();