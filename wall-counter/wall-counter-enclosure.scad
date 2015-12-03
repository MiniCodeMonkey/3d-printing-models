displayWidth = 120;
displayHeight = 41;
displayDepth = 5;
displaySpacing = 3;

labelSlotWidth = displayWidth;
labelSlotHeight = 30;
labelSlotDepth = 2;

enclosureInsideWidth = (displayWidth * 2) + displaySpacing;
enclosureInsideHeight = displayHeight * 1.1 + labelSlotHeight;
enclosureInsideDepth = 25;
enclosureThickness = 3;

module sevenSegDisplay() {
	cube([displayWidth, displayDepth, displayHeight]);
}

module combinedSevenSegDisplay() {
	sevenSegDisplay();
	translate([displayWidth + displaySpacing, 0, 0])
	sevenSegDisplay();
}

module enclosure() {
	difference() {
		// Outside
		translate([-enclosureThickness, -enclosureThickness, -enclosureThickness])
		cube([
			enclosureInsideWidth + (enclosureThickness * 2),
			enclosureInsideDepth + (enclosureThickness * 2),
			enclosureInsideHeight + (enclosureThickness * 2)
		]);
		
		// Inside
		cube([enclosureInsideWidth, enclosureInsideDepth, enclosureInsideHeight]);
	}
}

module labelBackground() {
	translate([0, -enclosureThickness, 0])
		cube([
			labelSlotWidth,
			labelSlotDepth * 3,
			labelSlotHeight
		]);
}

module labelSlot() {
	translate([-5, 0, 0])
		cube([
			labelSlotWidth + 5,
			labelSlotDepth,
			labelSlotHeight
		]);
}

module labelSlotCutOut() {
	height = labelSlotHeight * 0.9;

	translate([-5, -(labelSlotDepth * 4.5), (labelSlotHeight - height) / 2])
		cube([
			labelSlotWidth + 5,
			labelSlotDepth * 5,
			height
		]);
}

module entireClosure() {
	difference() {
		difference() {
			difference() {
				union() {
					enclosure();
					labelBackground();
				}

				translate([0, -(displayDepth * 2.5), enclosureInsideHeight - displayHeight])
				scale([1, 5, 1])
				combinedSevenSegDisplay();
			}

			labelSlot();
		}

		labelSlotCutOut();
	}
}

entireClosure();
