```scad
$fn = 100; // Smoothness

module shaft_body() {
    union() {
        // Central bulge
        cylinder(h = 20, r1 = 9, r2 = 9, center = true);

        // Tapered transition to middle shaft
        translate([0, 0, -10])
            cylinder(h = 10, r1 = 7, r2 = 9);

        translate([0, 0, 0])
            cylinder(h = 10, r1 = 9, r2 = 7);

        // Middle shaft sections
        translate([0, 0, -30])
            cylinder(h = 20, r = 7);

        translate([0, 0, 20])
            cylinder(h = 20, r = 7);

        // End sections
        translate([0, 0, -50])
            cylinder(h = 20, r = 6);

        translate([0, 0, 40])
            cylinder(h = 20, r = 6);

        // Grooves on both ends
        for (i = [-1, 0, 1]) {
            translate([0, 0, -45 + i * 5])
                difference() {
                    cylinder(h = 1, r = 6.5);
                    cylinder(h = 1, r = 6);
                }

            translate([0, 0, 45 + i * 5])
                difference() {
                    cylinder(h = 1, r = 6.5);
                    cylinder(h = 1, r = 6);
                }
        }

        // Through-holes on both ends
        for (z = [-45, 45]) {
            rotate([90, 0, 0])
                translate([0, z, -1.5])
                    cylinder(h = 3, r = 1.2);
        }

        // Key slots (rectangular cuts)
        for (z = [-45, 45]) {
            rotate([0, 0, 45])
                translate([-1, -3, z])
                    cube([2, 6, 1], center = true);
        }
    }
}

shaft_body();
```

