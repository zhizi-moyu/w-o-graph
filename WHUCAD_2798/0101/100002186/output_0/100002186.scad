```scad
$fn = 100; // Smoothness

module hex_socket_bolt(head_d=10, head_h=6, shaft_d=5, shaft_h=20, hex_r=3.5) {
    union() {
        // Shaft
        cylinder(h=shaft_h, d=shaft_d);

        // Head
        translate([0, 0, shaft_h])
            difference() {
                cylinder(h=head_h, d=head_d);
                // Hex socket
                translate([0, 0, head_h/3])
                    cylinder(h=head_h, r=hex_r, $fn=6);
            }
    }
}

// Call the bolt module
hex_socket_bolt();
```

