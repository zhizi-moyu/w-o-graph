```scad
// Parameters
base_length = 60;
base_width = 10;
base_thickness = 4;

vertical_height = 40;
vertical_thickness = 4;

fillet_radius = 6;

pin_radius = 3;
pin_height = 6;
pin_offset = 45; // distance from vertical arm to pin center

module angled_bracket_with_pin() {
    // Horizontal base
    base = cube([base_length, base_width, base_thickness]);

    // Vertical arm
    vertical = translate([0, 0, base_thickness])
        cube([vertical_thickness, base_width, vertical_height]);

    // Fillet (approximate with cylinder and hull)
    fillet = translate([0, 0, base_thickness])
        rotate([0, 90, 0])
        cylinder(r=fillet_radius, h=vertical_thickness, $fn=50);

    // Pin
    pin = translate([pin_offset, base_width/2, -pin_height])
        rotate([90, 0, 0])
        cylinder(r=pin_radius, h=pin_height, $fn=50);

    // Combine all
    union() {
        base;
        vertical;
        fillet;
        pin;
    }
}

// Render the model
angled_bracket_with_pin();
```

