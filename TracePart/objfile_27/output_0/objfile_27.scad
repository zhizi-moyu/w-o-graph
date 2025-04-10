```scad
// Parameters
coupling_length = 40;
coupling_diameter = 20;
shaft_hole_diameter = 10;
set_screw_diameter = 5;
set_screw_length = 8;
set_screw_offset = 10; // distance from center to each screw

// Coupling Body
module coupling_body() {
    difference() {
        // Outer body
        cylinder(h = coupling_length, d = coupling_diameter, $fn=100);
        // Shaft hole
        translate([0, 0, -1])
            cylinder(h = coupling_length + 2, d = shaft_hole_diameter, $fn=100);
        // Set screw holes
        for (pos = [-set_screw_offset, set_screw_offset]) {
            translate([coupling_diameter/2, pos, coupling_length/2])
                rotate([0,90,0])
                    cylinder(h = coupling_diameter, d = set_screw_diameter, $fn=60);
        }
    }
}

// Set Screw
module set_screw() {
    union() {
        // Screw body
        cylinder(h = set_screw_length, d = set_screw_diameter, $fn=60);
        // Hex socket (simplified as a cylinder)
        translate([0, 0, set_screw_length - 2])
            cylinder(h = 2, d = 3.5, $fn=6);
    }
}

// Assembly
module coupling_assembly() {
    coupling_body();
    // Insert set screws
    for (pos = [-set_screw_offset, set_screw_offset]) {
        translate([coupling_diameter/2 + 0.1, pos, coupling_length/2])
            rotate([0,90,0])
                set_screw();
    }
}

// Render the full model
coupling_assembly();
```
 