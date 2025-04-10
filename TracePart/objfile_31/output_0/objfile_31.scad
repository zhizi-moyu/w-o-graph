```scad
$fn = 100; // Smoothness

// Parameters
body_diameter = 20;
body_length = 30;
bore_diameter = 6;
set_screw_diameter = 3;
set_screw_length = 6;
helical_slot_width = 2;
helical_turns = 5;
helical_pitch = body_length / helical_turns;

// Main assembly
difference() {
    union() {
        // Helical body
        cylinder(h = body_length, d = body_diameter, center = true);

        // Set screws (4 total, 2 on each end)
        for (z = [-body_length/2 + 2, body_length/2 - 2]) {
            rotate([90, 0, 0])
                translate([0, z, body_diameter/2 - 1.5])
                    set_screw();
        }
    }

    // Central bore
    cylinder(h = body_length + 2, d = bore_diameter, center = true);

    // Helical slots
    for (i = [0 : helical_turns - 1]) {
        rotate_extrude(angle = 360)
            translate([body_diameter/2 - 1, 0, 0])
                translate([0, 0, i * helical_pitch])
                    square([helical_slot_width, helical_pitch], center = true);
    }

    // Set screw holes
    for (z = [-body_length/2 + 2, body_length/2 - 2]) {
        rotate([90, 0, 0])
            translate([0, z, body_diameter/2 - 1.5])
                cylinder(h = set_screw_length, d = set_screw_diameter, center = true);
    }
}

// Set screw module
module set_screw() {
    union() {
        // Screw body
        cylinder(h = set_screw_length, d = set_screw_diameter, center = true);
        // Hex socket
        translate([0, 0, set_screw_length/2 - 0.5])
            cylinder(h = 1, d = 2, $fn = 6, center = true);
    }
}
```

