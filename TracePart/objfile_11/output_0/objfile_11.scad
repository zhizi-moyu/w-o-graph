
$fn = 100; // Smoothness

// Main body with grooves
module main_cylindrical_body() {
    difference() {
        cylinder(h = 30, d = 30);
        
        // Central hole for shaft insert
        translate([0, 0, -1])
            cylinder(h = 32, d = 10);
        
        // Grooves
        for (i = [1:3]) {
            translate([0, 0, i * 6 + 4])
                cylinder(h = 2, d = 32);
        }

        // Set screw holes (2 holes at 120° apart)
        for (angle = [0, 120]) {
            rotate([0, 0, angle])
                translate([15, 0, 10])
                    rotate([90, 0, 0])
                        cylinder(h = 5, d = 4);
        }
    }
}

// Shaft insert
module shaft_insert() {
    translate([0, 0, 30])
        cylinder(h = 15, d = 10);
}

// Set screw (simplified as a small cylinder)
module set_screw() {
    color("black")
        cylinder(h = 5, d = 4);
}

// Assembly
module coupling() {
    union() {
        main_cylindrical_body();
        shaft_insert();
        
        // Set screws inserted into holes
        for (angle = [0, 120]) {
            rotate([0, 0, angle])
                translate([15, 0, 10])
                    rotate([90, 0, 0])
                        set_screw();
        }
    }
}

coupling();

