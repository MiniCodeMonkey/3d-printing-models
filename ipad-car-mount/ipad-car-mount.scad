deviceThickness = 9.75;
holderThickness = 3;
holderWidth = 145; // Make this wider if your printer build volume allows it!
holderHeight = 40;

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

difference() {
	difference() {
		difference() {
			holder();
			deviceCutOut();
		}

		frontLip();
	}
}