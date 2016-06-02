bookThickness = 15;
holderThickness = 3;
holderWidth = 90;
holderHeight = 60;

screwHoleDiameterOut = 4;
screwHoleDiameterIn = 7.85;

module holder() {
	cube([holderWidth, bookThickness + (holderThickness * 2), holderHeight]);
}

module deviceCutOut() {
	translate([-holderWidth * 0.25, holderThickness, holderThickness])
	cube([holderWidth * 1.5, bookThickness, holderHeight]);	
}

module frontLip() {
	translate([-holderWidth * 0.25, -holderThickness * 2, holderThickness + (holderHeight / 1.75)])
	cube([holderWidth * 1.5, bookThickness, holderHeight]);	
}

module screwHole() {
	rotate([90, 0, 0])
	cylinder(h=holderThickness, r1=screwHoleDiameterOut / 2, r2 = screwHoleDiameterIn / 2, center=false, $fn=80);
}

difference() {
	difference() {
		difference() {
			holder();
			deviceCutOut();
		}

		frontLip();
	}

	translate([holderWidth / 4, bookThickness + (holderThickness * 2), holderHeight / 1.25])
	screwHole();

	translate([(holderWidth / 4) * 3, bookThickness + (holderThickness * 2), holderHeight / 1.25])
	screwHole();
}