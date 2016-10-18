screenWidthAndHeight = 24.5;

boxWidth = 37;
boxHeight = 55;
boxDepth = 10;
thickness = 1;
cornerRadius = 1.25;

renderPart = "all";

$fn=100;

module screenCutOut() {
	cube([screenWidthAndHeight, screenWidthAndHeight, 10], center = true);
}

module mainBox() {
	difference() {
		minkowski() {
			cube([boxHeight, boxWidth, boxDepth], center = true);
			sphere(r=cornerRadius);
		}

		cube([boxHeight - thickness, boxWidth - thickness, boxDepth - thickness], center = true);
	}
}

module buttonCutout() {
	cylinder(h=100, r=2);
}

difference() {
	color("black")
	mainBox();

	translate([-5, 0, 5])
	screenCutOut();

	rotate([90, 90, 0])
	translate([0, 0, -50])
	buttonCutout();

	translate([18, 0, 0])
	buttonCutout();

	topPartHeight = 1.8;

	if (renderPart == "top") {
		translate([0, 0, -topPartHeight])
		cube([boxHeight + cornerRadius * 2, boxWidth + cornerRadius * 2, boxDepth + cornerRadius * 2], center = true);
	} else if (renderPart == "bottom") {
		translate([0, 0, boxDepth + (cornerRadius * 2) - topPartHeight])
		cube([boxHeight + cornerRadius * 2, boxWidth + cornerRadius * 2, boxDepth + cornerRadius * 2], center = true);
	}
}

