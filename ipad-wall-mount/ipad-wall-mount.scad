deviceThickness = 9.75;
holderThickness = 3;
holderWidth = 145; // Make this wider if your printer build volume allows it!
holderHeight = 40;

screwHoleDiameterOut = 4;
screwHoleDiameterIn = 7.85;

module holder() {
	cube([holderWidth, deviceThickness + (holderThickness * 2), holderHeight]);
}

module deviceCutOut() {
	translate([-holderWidth * 0.25, holderThickness, holderThickness])
	cube([holderWidth * 1.5, deviceThickness, holderHeight]);	
}

module frontLip() {
	translate([-holderWidth * 0.25, -holderThickness * 2, holderThickness + (holderHeight / 3)])
	cube([holderWidth * 1.5, deviceThickness, holderHeight]);	
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

	translate([holderWidth / 4, deviceThickness + (holderThickness * 2), holderHeight / 1.5])
	#screwHole();

	translate([(holderWidth / 4) * 3, deviceThickness + (holderThickness * 2), holderHeight / 1.5])
	screwHole();
}