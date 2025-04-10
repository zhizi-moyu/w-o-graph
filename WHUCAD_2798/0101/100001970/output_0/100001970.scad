
// Parameters
large_diameter = 40;
large_height = 30;

small_diameter = 20;
small_height = 10;

cavity_depth = 5;
cavity_diameter = 30;

module stepped_cylinder_shaft() {
    difference() {
        // Main body: large cylinder + small bottom cylinder
        union() {
            // Large top cylinder
            cylinder(h = large_height, d = large_diameter, $fn=64);
            
            // Small bottom cylinder
            translate([0, 0, -small_height])
                cylinder(h = small_height, d = small_diameter, $fn=64);
        }

        // Recessed cavity in the bottom of the large cylinder
        translate([0, 0, -cavity_depth])
            cylinder(h = cavity_depth, d = cavity_diameter, $fn=64);
    }
}

// Render the model
stepped_cylinder_shaft();

