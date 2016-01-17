height = 40;
itemWidth = 142;
itemThicknessMin = 5.2;
itemThicknessMax = 18;
itemsCount = 5;

$fn = 1000;

// From http://www.thingiverse.com/thing:9347/#files
module roundedRect(size, radius)
{
    x = size[0];
    y = size[1];
    z = size[2];

    linear_extrude(height=z)
    hull()
    {
        // place 4 circles in the corners, with the given radius
        translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
        circle(r=radius);
    
        translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
        circle(r=radius);
    
        translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
        circle(r=radius);
    
        translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
        circle(r=radius);
    }
}

module container() {
    difference() {
        outerWidth = itemWidth;

        x = outerWidth;
        y = itemsCount * itemThicknessMax;
        z = height;

        translate([x / 2, y / 2, 0])
            roundedRect([x, y, z], 5);

        translate([0, 0, 2])
            cube([itemWidth, itemsCount * itemThicknessMax, height * 2]);
    }
}

module slots() {
    for (a = [0 : itemsCount - 1]) {
        difference() {
            translate([0, (a * itemThicknessMax), 0])
                cube([itemWidth, itemThicknessMax, height * 1]);

            translate([0, (a * itemThicknessMax), 0])
                cube([itemWidth, itemThicknessMin, height * 3]);
        }
    }
}

container();
slots();