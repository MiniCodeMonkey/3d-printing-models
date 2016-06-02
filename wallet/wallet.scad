length = 94;
innerWidth = 55;
height = 28;
thickness = 2.2;

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

difference() {
	union() {
		fullMainStructure();

		translate([0, 0, 1 + (thickness * 3)])
		topSlideRail();
	}

	finalTopCutout();
}

//creditCard();