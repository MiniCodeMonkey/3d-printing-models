length = 94;
innerWidth = 55;
height = 28;
thickness = 2.2;
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
	translate([0, thickness * 2, height / 2 - 2])
	cube([innerWidth, length + (thickness * 2), 10], center = true);
}

module bottomCutout() {
	translate([0, 0, -height / 2 - 2])
	cube([innerWidth, length + (thickness * 2), 10], center = true);
}

module fullMainStructure() {
	difference() {
		mainStructure();

		scale([0.955, 0.955, 0.955])
		mainStructure();

		topCutout();
	}
}

module creditCard() {
	translate([0, 0, 8])
	cube([54, 85.6, 1.2], center = true);
}

module topSlideRail() {
	difference() {
		translate([0, 0, 0])
		cube([innerWidth, 94, 1.2 + (thickness * 2)], center = true);

		translate([0, thickness, 0])
		cube([54, 85.6 + 10, 1.2], center = true);

		translate([0, thickness, 0])
		cube([54 - 5, 85.6 + 10, 1.2 + (thickness * 3)], center = true);
	}
}

module finalTopCutout() {
	translate([0, 0, height / 2 + 1])
	cube([innerWidth * 1.5, length + (thickness * 2), 10], center = true);
}

module mountingHole() {
	cylinder(h = 6, d = 2);
}

module screenCutOut() {
	cube([screenWidthAndHeight, screenWidthAndHeight, thickness * 10], center = true);
}

module screenMount() {
	translate([0, 0, 0])
	mountingHole();

	translate([0, 34.8, 0])
	mountingHole();

	translate([34.8, 0, 0])
	mountingHole();

	translate([34.8, 34.8, 0])
	mountingHole();
}

module usbCutOut() {
	cube([thickness * 10, usbWidth, usbHeight], center = true);
}

module mcuMount() {
	translate([0, 0, 0])
	mountingHole();

	translate([0, 19, 0])
	mountingHole();

	translate([47.5, 0, 0])
	mountingHole();

	translate([47.5, 19, 0])
	mountingHole();	
}

module fingerGrip() {
	rotate([90, 0, 0])
	cylinder(h = length, d = fingerDiamater, center = true);
}

module fingerHole() {
	cylinder(h = 8, d = fingerDiamater * 0.8, center = true);
}

module fingerHoleProtector() {
	difference() {
		cylinder(h = 6, d = fingerDiamater * 1.15, center = true);
		fingerHole();
	}
}

difference() {
	difference() {
		union() {
			fullMainStructure();

			translate([0, 0, 1 + (thickness * 3)])
			topSlideRail();
		}

		finalTopCutout();
	}

	translate([-34.8 / 2 + screenWidthAndHeight / 2 + 3.5, -6 + 4.9 + screenWidthAndHeight, -12])
	screenCutOut();

	translate([47.5 / 2, -40 + 19 / 2 + 4, -9.5])
	usbCutOut();

	translate([0, -10, 8])
	fingerGrip();

	translate([20, 22, -10])
	fingerHole();
}

translate([-34.8 / 2, 6, -12])
screenMount();

translate([-47.5 / 2, -40 + 4, -12])
mcuMount();

//translate([19, 22, -9.5])
//fingerHoleProtector();

//creditCard();