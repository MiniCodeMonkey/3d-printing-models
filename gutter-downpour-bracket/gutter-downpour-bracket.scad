height = 29;
depth = 74;
width = 81.5;
thickness = 2;
mountingSpacerWidth = 30;

screwHoleDiameterOut = 4;
screwHoleDiameterIn = 7.85;

module screwHole() {
    cylinder(h=thickness, r1=screwHoleDiameterIn / 2, r2 = screwHoleDiameterOut / 2, center=false, $fn=80);
}

// Front
cube([width, height, thickness]);

// Right
cube([thickness, height, depth]);

// Left
translate([width, 0, 0])
cube([thickness, height, depth]);

// Mounting spacer
// Right
difference() {
    translate([-mountingSpacerWidth + thickness, 0, depth])
    cube([mountingSpacerWidth, height, thickness]);

    translate([-mountingSpacerWidth / 2 + thickness, height / 2, depth])
    screwHole();
}

// Left
difference() {
    translate([width, 0, depth])
    cube([mountingSpacerWidth, height, thickness]);

    translate([width + mountingSpacerWidth / 2, height / 2, depth])
    #screwHole();
}