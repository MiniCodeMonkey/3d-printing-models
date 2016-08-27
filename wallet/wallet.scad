include <standoff.scad>

length = 93;
innerWidth = 55;
height = 28;
thickness = 2;
fingerDiamater = 16;

screenWidthAndHeight = 24.5;

usbWidth = 8.1;
usbHeight = 4.4;

$fn = 200;

module base() {
	cube([innerWidth, length, height * 0.9], center = true);
}

module side() {
	rotate([90, 0, 0])
	translate([-innerWidth / 3.3, 0, 0])
	cylinder(h = length, d = height, center = true);
}

module bothSides() {
	union() {
		side();

		mirror([1, 0, 0])
		side();

		translate([0, 0, -8])
		cube([innerWidth + 10, length, height * 0.3], center = true);
	}
}

module mainStructure() {
	hull() {
		difference() {
			bothSides();
			bottomCutout();
		}

		base();
	}
}

module topCutout() {
	translate([0, thickness * 2, height / 2 - 3])
	cube([innerWidth, length + thickness - 2, 10], center = true);
}

module bottomCutout() {
	translate([0, 0, -height / 2 - 2])
	cube([innerWidth, length + (thickness * 2), 10], center = true);
}

module fullMainStructure() {
	difference() {
		mainStructure();

		scale([0.92, 0.92, 0.92])
		mainStructure();

		topCutout();
	}
}

module creditCard() {
	translate([0, 0, 8])
	cube([54, 85.6, 1.2], center = true);
}

module topSlideRail() {
	creditCardThickness = 1.8;
	creditCardWidth = 55;

	difference() {
		// Main structure
		translate([0, 0, 0])
		cube([innerWidth, length, creditCardThickness + (thickness * 2)], center = true);

		// Credit card cut out
		translate([0, thickness + 4, 0])
		cube([creditCardWidth, 85.6 + 10, creditCardThickness], center = true);

		// Inner cutout
		translate([0, thickness, 0])
		cube([creditCardWidth - 5, 85.6 + 10, creditCardThickness + (thickness * 3)], center = true);
	}
}

module finalTopCutout() {
	translate([0, 0, height / 2 + 1])
	cube([innerWidth * 1.5, length + (thickness * 2), 10], center = true);
}

module pcbSnapStandoff() {
	boardmount(HoleD = 2.7, BoardThick = 1.60, lift=2);
}

module screenCutOut() {
	cube([screenWidthAndHeight, screenWidthAndHeight, thickness * 10], center = true);
}

module screenMount() {
	translate([0, 0, 0])
	pcbSnapStandoff();

	translate([0, 33.1, 0])
	pcbSnapStandoff();

	translate([33.4, 0, 0])
	pcbSnapStandoff();

	translate([33.4, 33.1, 0])
	pcbSnapStandoff();
}

module usbCutOut() {
	cube([thickness * 10, usbWidth, usbHeight], center = true);

	translate([thickness * 2 + 2, 0, 0])
	cube([thickness * 2, usbWidth * 4, usbHeight * 1.6], center = true);
}

module mcuMount() {
	translate([0, 0, 0])
	pcbSnapStandoff();

	translate([0, 17.5, 0])
	pcbSnapStandoff();

	translate([44.95, 0, 0])
	pcbSnapStandoff();

	translate([44.95, 17.5, 0])
	pcbSnapStandoff();	
}

module fingerGrip() {
	rotate([90, 0, 0])
	union() {
		translate([0, 46, length / 2 - 10])
		cube([fingerDiamater, length, fingerDiamater], center = true);

		cylinder(h = length, d = fingerDiamater, center = true);
	}
}

module wallet() {
	screenCenterDelta = 1.5;
	difference() {
		difference() {
			union() {
				fullMainStructure();

				translate([0, 0, 1 + (thickness * 3)])
				topSlideRail();
			}

			finalTopCutout();
		}

		translate([-34.8 / 2 + screenWidthAndHeight / 2 + 3.25 + screenCenterDelta, -0.85 + screenWidthAndHeight, -12])
		screenCutOut();

		translate([47.5 / 2, -26 + 17.5 / 2, -7.5])
		usbCutOut();

		translate([0, -10, 2])
		fingerGrip();
	}

	translate([-34.8 / 2 + screenCenterDelta, 6, -12])
	screenMount();

	translate([-47.5 / 2 + 8.5, -26, -12])
	mcuMount();
}

wallet();