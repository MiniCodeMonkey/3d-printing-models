screenWidthAndHeight = 24.5;

boxWidth = 50;
boxHeight = 55;
boxDepth = 10;
thickness = 1;
cornerRadius = 1.25;

usbWidth = 8.1;
usbHeight = 4;

renderPart = "bottom"; // bottom, top, or all
enableMockup = false;

$fn=20;

module screenCutOut() {
	cylinder(10, d=screenWidthAndHeight, center = true, $fn=250);
}

module mainBox() {
	difference() {
		union() {
			difference() {
				minkowski() {
					cylinder(boxDepth, d=boxWidth, center = true);
					sphere(r=cornerRadius);
				}

				cylinder(boxDepth - thickness, d = boxWidth - thickness, center = true);
			}

			translate([35, 0, 0])
			minkowski() {
				cube([30, 27, boxDepth], center = true);
				sphere(r=cornerRadius);
			}
		}

		translate([32.5, 0, 0])
		cube([35, 27, boxDepth - thickness], center = true);
	}
}

module buttonCutout() {
	cylinder(h=100, r=2, $fn=250);
}

module usbCutOut() {
	cube([thickness * 10, usbWidth, usbHeight], center = true);
}

module standoff() {
	cylinder(h=3, r=1);
}

module pcbStandOffs() {
	translate([-21.7, 8.9, -6])
	standoff();
	translate([-21.7, -8.9, -6])
	standoff();
	translate([24.5, -8.9, -6])
	standoff();
	translate([24.5, 8.9, -6])
	standoff();
}

module screenStandOffs() {
	translate([0, 0, 0])
	standoff();

	translate([0, 33.1, 0])
	standoff();

	translate([33.4, 0, 0])
	standoff();

	translate([33.4, 33.1, 0])
	standoff();
}

difference() {
	color("black")
	mainBox();

	translate([0, 0, 5])
	screenCutOut();

	translate([25, 0, 0])
	buttonCutout();

	translate([50, 0, -2])
	usbCutOut();

	topPartHeight = 1.8;

	if (renderPart == "top") {
		translate([0, 0, -topPartHeight])
		cube([boxHeight + cornerRadius * 2 + 200, boxWidth + cornerRadius * 2, boxDepth + cornerRadius * 2], center = true);
	} else if (renderPart == "bottom") {
		translate([0, 0, boxDepth + (cornerRadius * 2) - topPartHeight])
		cube([boxHeight + cornerRadius * 2 + 200, boxWidth + cornerRadius * 2, boxDepth + cornerRadius * 2], center = true);
	}
}

if (renderPart != "top") {
	translate([22, 0, 0])
	pcbStandOffs();
}

if (renderPart != "bottom") {
	//translate([-18, -17, 2.5])
	//screenStandOffs();
}

if (enableMockup) {
	if (renderPart != "top") {
		color("red")
		rotate([0, 0, 180])
		translate([-52, -8, -4.7 + thickness])
		import("vendor/Adafruit_Feather_Bluefruit_LE_32u4_wo_header.stl");
	}
}