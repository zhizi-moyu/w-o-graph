```scad
// Parameters
base_size = 60;         // Width and depth of the base plate
base_thickness = 5;     // Thickness of the base plate
back_height = 40;       // Height of the vertical backplate
hole_radius = 12;       // Radius of the central hole
corner_hole_radius = 2.5; // Radius of the corner mounting holes
slot_width = 5;         // Width of the vertical slots
slot_height = 20;       // Height of the vertical slots
slot_offset_x = 15;     // Horizontal offset of slots from center
slot_offset_y = 10;     // Vertical offset from top of backplate
rounding_radius = 3;    // Radius for rounded corners

module mounting_bracket() {
    difference() {
        union() {
            // Base plate
            cube([base_size, base_size, base_thickness], center=false);

            // Backplate
            translate([0, 0, base_thickness])
                cube([base_size, base_thickness, back_height], center=false);
        }

        // Central hole
        translate([base_size/2, base_size/2, -1])
            cylinder(h=base_thickness+2, r=hole_radius, $fn=64);

        // Corner holes
        for (x = [corner_hole_radius + 5, base_size - corner_hole_radius - 5])
            for (y = [corner_hole_radius + 5, base_size - corner_hole_radius - 5])
                translate([x, y, -1])
                    cylinder(h=base_thickness+2, r=corner_hole_radius, $fn=32);

        // Vertical slots in backplate
        for (x = [base_size/2 - slot_offset_x, base_size/2 + slot_offset_x])
            translate([x - slot_width/2, base_thickness - 0.1, base_thickness + slot_offset_y])
                cube([slot_width, base_thickness + 0.2, slot_height], center=false);
    }

    // Optional: Rounded corners (visual only, not functional in this simple model)
    // Could use minkowski() with a sphere for true rounding if needed
}

mounting_bracket();
```

