
// Parameters
arm_length = 30;
arm_width = 5;
thickness = 3;
corner_radius = 5;

// Module to create a single L-bracket
module L_bracket() {
    difference() {
        union() {
            // Horizontal arm
            cube([arm_length, arm_width, thickness]);

            // Vertical arm
            translate([0, 0, 0])
                cube([arm_width, arm_length, thickness]);

            // Rounded outer corner
            translate([0, 0, 0])
                rotate([0, 0, 0])
                    translate([arm_width - corner_radius, arm_width - corner_radius, 0])
                        cylinder(h = thickness, r = corner_radius, $fn = 50);
        }

        // Remove the inner corner to keep it sharp
        translate([0, 0, -1])
            cube([arm_width, arm_width, thickness + 2]);
    }
}

// Display the L-bracket
L_bracket();

