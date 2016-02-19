height = 40;
itemWidth = 142;
itemThicknessMin = 5.2;
itemThicknessMax = 18;
itemsCount = 5;

$fn = 1000;

module container() {
    /*difference() {
        outerWidth = itemWidth;

        x = outerWidth;
        y = itemsCount * itemThicknessMax;
        z = height;

        translate([x / 2, y / 2, 0])
            roundedRect([x, y, z], 5);

        translate([0, 0, 2])
            cube([itemWidth, itemsCount * itemThicknessMax, height * 2]);
    }*/

    difference() {
        difference() {
            translate([itemWidth / 2, itemsCount * itemThicknessMax, 0])
            rotate([90, 0, 0])
                cylinder((itemsCount * itemThicknessMax) + (itemThicknessMax - itemThicknessMin), itemWidth / 4, itemWidth / 2);

            translate([0, -itemThicknessMax, -itemWidth / 2 - itemThicknessMax])
                cube([itemWidth, (itemsCount + 2) * itemThicknessMax, height * 2]);
        }

        translate([0, -itemThicknessMax, -(itemThicknessMax - itemThicknessMin) + height])
                cube([itemWidth, (itemsCount + 2) * itemThicknessMax, height * 2]);
    }
}

module slots() {
    for (a = [0 : itemsCount - 1]) {
        translate([0, (a * itemThicknessMax), 0])
            cube([itemWidth, itemThicknessMin, height * 10]);
    }
}

difference() {
    container();
    slots();
}