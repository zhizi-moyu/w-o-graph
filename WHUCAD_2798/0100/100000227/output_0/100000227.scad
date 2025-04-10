
$fn = 100; // Smoothness

// Parameters
fork_arm_length = 40;
fork_arm_thickness = 5;
fork_arm_width = 10;
fork_gap = 10;
fork_base_diameter = 15;
fork_base_height = 10;
hole_diameter = 4;

tongue_length = 20;
tongue_width = fork_gap;
tongue_thickness = fork_arm_thickness;
tongue_hole_offset = 5;
tongue_shaft_diameter = 10;
tongue_shaft_height = 20;

pin_diameter = hole_diameter;
pin_length = fork_gap + 2 * fork_arm_thickness;

// Fork End Connector
module fork_end_connector() {
    // Base cylinder
    translate([0, 0, 0])
        cylinder(h = fork_base_height, d = fork_base_diameter);

    // Arms
    for (side = [-1, 1]) {
        translate([side * (fork_gap + fork_arm_thickness) / 2, -fork_arm_width / 2, fork_base_height])
            cube([fork_arm_thickness, fork_arm_width, fork_arm_length]);
        
        // Holes in arms
        translate([side * (fork_gap + fork_arm_thickness) / 2 + fork_arm_thickness / 2, 0, fork_base_height + fork_arm_length / 2])
            rotate([90, 0, 0])
                cylinder(h = fork_arm_width + 1, d = hole_diameter);
    }
}

// Tongue End Connector
module tongue_end_connector() {
    // Tongue
    translate([-tongue_thickness / 2, -tongue_width / 2, fork_base_height + fork_arm_length / 2 - tongue_length / 2])
        cube([tongue_thickness, tongue_width, tongue_length]);

    // Holes
    for (side = [-1, 1]) {
        translate([0, side * tongue_width / 2, fork_base_height + fork_arm_length / 2])
            rotate([90, 0, 0])
                cylinder(h = tongue_thickness + 1, d = hole_diameter);
    }

    // Shaft
    translate([0, 0, fork_base_height + fork_arm_length / 2 - tongue_length / 2 - tongue_shaft_height])
        cylinder(h = tongue_shaft_height, d = tongue_shaft_diameter);
}

// Pin
module pin() {
    translate([0, 0, fork_base_height + fork_arm_length / 2])
        rotate([90, 0, 0])
            cylinder(h = pin_length, d = pin_diameter);
}

// Assembly
union() {
    fork_end_connector();
    tongue_end_connector();
    pin();
}

