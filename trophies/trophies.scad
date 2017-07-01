baseWidth = 150;
baseHeight = baseWidth / 5;
lineHeight = 7;
textThickness = 3;
verticalTextOffset = 3.5;

COLOR_VBRED = [237 / 255, 28 / 255, 36 / 255];
COLOR_GOLD = [255 / 255, 215 / 255, 0 / 255];
COLOR_WHITE = [255 / 255, 255 / 255, 255 / 255];
COLOR_BASE = COLOR_WHITE;

module base() {
    rotate([0, 0, 45])
    cylinder(h=baseHeight, d1=baseWidth, d2=baseWidth*0.8, center=true, $fn=4);
}

module cauldron() {
    // Cauldron & spoon by MakerBot, from: http://www.thingiverse.com/thing:32906

    difference() {
        import("witch_cauldron_x1.stl");

        // Removes the separate handles from cauldron
        boxToRemoveCauldronSeparateParts();
        mirror([1, 0, 0]) boxToRemoveCauldronSeparateParts();
    }
}

module spoon() {
    // Cauldron & spoon by MakerBot, from: http://www.thingiverse.com/thing:32906
    import("spoon.stl");
}

module football() {
    // Football by davew_tx, from http://www.thingiverse.com/thing:207725
    import("football_whole.stl");
}

module boxToRemoveCauldronSeparateParts() {
    translate([29, 0, -5])
    cube([20, baseWidth, 20], center = true);
}

module description(name) {
    color(COLOR_WHITE)
    translate([0, -8, 0])
    cube([baseWidth * 0.55, baseHeight * 0.8, textThickness], center = true);

    color(COLOR_VBRED)
    translate([0, -verticalTextOffset + -lineHeight * 0.4, 0])
    linear_extrude(height = textThickness) {
        text("Souper Bowl 2017", font = "Open Sans", size = 5, halign = "center");
    }

    color(COLOR_VBRED)
    translate([0, -verticalTextOffset + -lineHeight * 1.75, 0])
    linear_extrude(height = textThickness) {
        text(name, font = "Open Sans:style=Bold", size = 6, halign = "center");
    }

}

module top() {
    translate([0, 0, 6])
    color("red")
    scale([2.5, 2.5, 2.5])
    rotate([0, 0, 90])
    cauldron();

    // translate([0, 30, 60])
    // scale([1.7, 1.7, 1.7])
    // spoon();

    translate([-53, 36, 80])
    rotate([0, -49, 0])
    rotate([180, 0, 0])
    scale([0.55, 0.55, 0.55])
    football();

    translate([0, 0, 30])
    cylinder(h=85, d1=75, d2=89.3, center=true, $fn=100);
}

module trophy() {
    base();
    top();

    translate([0, -44.5, 8])
    rotate([70, 0, 0])
    description("Best Veggie");
}

module handles() {
    // Cauldron & spoon by MakerBot, from: http://www.thingiverse.com/thing:32906

    difference() {
        import("witch_cauldron_x1.stl");

        // Removes the cauldron
        cube([42, 50, 100], center=true);
    }
}

trophy();

//scale([2.5, 2.5, 2.5])
//handles();