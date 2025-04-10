
$fn = 100;

// Parameters
main_length = 60;
main_radius = 10;
bulge_radius = 12;
bulge_length = 20;
cut_width = 1.5;
cut_depth = 2;
num_cuts = 5;
screw_radius = 1.5;
screw_length = 8;
screw_offset = 8;

// Main module
module flexible_coupling() {
    difference() {
        union() {
            // Left shaft
            cylinder(h = (main_length - bulge_length)/2, r = main_radius);
            // Right shaft
            translate([0, 0, main_length - (main_length - bulge_length)/2])
                cylinder(h = (main_length - bulge_length)/2, r = main_radius);
            // Bulge
            translate([0, 0, (main_length - bulge_length)/2])
                cylinder(h = bulge_length, r1 = main_radius, r2 = bulge_radius);
        }

        // Helical cuts (simulated with rotated slots)
        for (i = [0:num_cuts-1]) {
            rotate([0, 0, i * 360 / num_cuts])
                translate([-cut_width/2, main_radius - cut_depth, i * main_length / num_cuts])
                    cube([cut_width, cut_depth, main_length / num_cuts + 2], center=false);
        }

        // Clamping screw holes
        for (z = [screw_offset, main_length - screw_offset]) {
            rotate([90, 0, 0])
                translate([z, -main_radius, -screw_radius])
                    cylinder(h = 2*main_radius, r = screw_radius);
        }

        // Slits at both ends
        for (z = [0, main_length - 1]) {
            translate([-cut_width/2, -main_radius, z])
                cube([cut_width, 2*main_radius, 2]);
        }
    }

    // Clamping screws
    for (z = [screw_offset, main_length - screw_offset]) {
        translate([0, main_radius + 0.5, z])
            rotate([90, 0, 0])
                clamping_screw();
    }
}

// Clamping screw module
module clamping_screw() {
    union() {
        cylinder(h = screw_length, r = screw_radius);
        // Hex socket (simplified)
        translate([0, 0, screw_length - 1])
            cylinder(h = 1, r = screw_radius * 0.8, $fn=6);
    }
}

// Render the model
flexible_coupling();
