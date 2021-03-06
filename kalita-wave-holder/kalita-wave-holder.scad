holderWidth = 65.5;
holderDepth = 80;
holderThickness = 8;
baseWidth = 30;

screwHoleDiameterOut = 4;
screwHoleDiameterIn = 7.85;

$fn = 250;

module screwHole() {
	rotate([0, 90, 0])
	cylinder(h=holderThickness, r1=screwHoleDiameterOut / 2, r2 = screwHoleDiameterIn / 2, center=false);

	rotate([0, 90, 0])
    translate([0, 0, -holderThickness * 3])
    cylinder(h=holderThickness * 3, d=screwHoleDiameterOut, center=false);
}

module base() {
    translate([(-holderDepth / 2) - 2, 0, 0])
    cube([holderThickness * 3, baseWidth, holderThickness], center = true);
}

module baseSupport() {
    translate([(-holderDepth / 2) - 2, 0, 0])
    
    intersection() {
        cube([holderThickness * 3, baseWidth, holderThickness * 4], center = true);
        
        translate([-holderThickness * 2, 0, 0])
        sphere(d = (holderThickness * 6));
    }
}

module holder() {
    difference() {
        cylinder(h = holderThickness, d = holderWidth + (holderThickness * 2), center = true);
        
        translate([0, 0, 0])
        cylinder(h = holderThickness * 2, d = holderWidth, center = true);
        
        translate([0, -holderWidth / 2, -holderThickness])
        cube([holderDepth, holderWidth, holderThickness * 2]);
    }
}

module holderSupport() {
    translate([0, -holderWidth / 2 - holderThickness, -holderThickness / 2])
    cube([holderDepth / 2.5, holderThickness, holderThickness]);
    
    translate([0, -holderWidth / 2 + holderWidth, -holderThickness / 2])
    cube([holderDepth / 2.5, holderThickness, holderThickness]);
}

difference() {
    union() {
        base();
        baseSupport();
        holder();
        holderSupport();
    }
    
    translate([(-holderDepth / 2) + (holderThickness / 2) - 1, 8, 0])
	screwHole();

    translate([(-holderDepth / 2) + (holderThickness / 2) - 1, -8, 0])
	screwHole();
}
