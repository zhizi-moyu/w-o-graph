```scad
$fn = 100; // Smoothness

// Parameters
hub_diameter = 30;
hub_length = 20;
hub_hole_diameter = 8;
teeth_height = 3;
teeth_count = 20;
teeth_width = 2;

gear_ring_thickness = 5;
gear_ring_inner_diameter = hub_diameter + 2 * teeth_height;
gear_ring_outer_diameter = gear_ring_inner_diameter + 4;

sleeve_length = 40;
sleeve_outer_diameter = gear_ring_outer_diameter + 4;
sleeve_inner_diameter = gear_ring_outer_diameter;

// Modules
module hub() {
    difference() {
        cylinder(d=hub_diameter, h=hub_length);
        translate([0, 0, -1])
            cylinder(d=hub_hole_diameter, h=hub_length + 2);
    }
    // External teeth
    for (i = [0:teeth_count - 1]) {
        angle = 360 / teeth_count * i;
        rotate([0, 0, angle])
        translate([hub_diameter / 2, -teeth_width / 2, 0])
            cube([teeth_height, teeth_width, hub_length]);
    }
}

module internal_gear_ring() {
    difference() {
        cylinder(d=gear_ring_outer_diameter, h=gear_ring_thickness);
        cylinder(d=gear_ring_inner_diameter, h=gear_ring_thickness + 1);
    }
    // Internal teeth (simplified as inward cubes)
    for (i = [0:teeth_count - 1]) {
        angle = 360 / teeth_count * i;
        rotate([0, 0, angle])
        translate([(gear_ring_inner_diameter / 2) - teeth_height, -teeth_width / 2, 0])
            cube([teeth_height, teeth_width, gear_ring_thickness]);
    }
}

module outer_sleeve() {
    difference() {
        cylinder(d=sleeve_outer_diameter, h=sleeve_length);
        translate([0, 0, -1])
            cylinder(d=sleeve_inner_diameter, h=sleeve_length + 2);
    }
}

// Assembly
module flexible_coupling() {
    // Outer sleeve
    translate([0, 0, 0])
        outer_sleeve();

    // Internal gear rings
    translate([0, 0, 5])
        internal_gear_ring();
    translate([0, 0, sleeve_length - gear_ring_thickness - 5])
        internal_gear_ring();

    // Input hub
    translate([0, 0, -hub_length + 5])
        hub();

    // Output hub
    translate([0, 0, sleeve_length - 5])
        rotate([180, 0, 0])
            hub();
}

// Render the full model
flexible_coupling();
```

