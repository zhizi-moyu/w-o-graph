```scad
// Parameters
jaw_width = 20;
jaw_height = 15;
jaw_depth = 30;
groove_radius = 10;
bolt_radius = 2;
bolt_spacing = 12;
core_radius = 10;
core_length = 10;
arm_thickness = 5;
arm_length = 10;
nut_size = 5;

// Modules
module left_jaw_block() {
    difference() {
        union() {
            // Base block
            cube([jaw_width, jaw_depth, jaw_height], center=false);
            
            // Interlocking arm
            translate([jaw_width/2 - arm_thickness/2, jaw_depth, jaw_height])
                rotate([90, 0, 0])
                cube([arm_thickness, arm_length, jaw_height], center=false);
        }
        // Semi-circular groove
        translate([jaw_width/2, jaw_depth/2, jaw_height/2])
            rotate([90, 0, 0])
            cylinder(h=jaw_depth+1, r=groove_radius, center=true);

        // Bolt holes
        for (x = [-bolt_spacing/2, bolt_spacing/2])
            translate([jaw_width/2 + x, jaw_depth - 2, jaw_height/2])
                rotate([90, 0, 0])
                cylinder(h=jaw_depth, r=bolt_radius, center=true);

        // Nut pockets
        for (x = [-bolt_spacing/2, bolt_spacing/2])
            translate([jaw_width/2 + x, 0, jaw_height/2])
                rotate([90, 0, 0])
                cylinder(h=5, r=nut_size, $fn=6);
    }
}

module right_jaw_block() {
    mirror([1, 0, 0])
        left_jaw_block();
}

module central_cylindrical_core() {
    translate([jaw_width/2, jaw_depth/2, jaw_height/2])
        rotate([90, 0, 0])
        cylinder(h=core_length, r=core_radius, center=true);
}

module bolt() {
    union() {
        // Shaft
        cylinder(h=jaw_depth + 5, r=bolt_radius, center=false);
        // Head
        translate([0, 0, jaw_depth + 5])
            cylinder(h=2, r=bolt_radius * 1.5, $fn=6);
    }
}

module nut() {
    cylinder(h=3, r=nut_size, $fn=6);
}

// Assembly
translate([0, 0, 0])
    left_jaw_block();

translate([jaw_width, 0, 0])
    right_jaw_block();

translate([jaw_width/2, jaw_depth/2, jaw_height/2])
    central_cylindrical_core();

// Bolts
for (x = [-bolt_spacing/2, bolt_spacing/2])
    translate([jaw_width/2 + x, jaw_depth - 2, jaw_height])
        bolt();

// Nuts
for (x = [-bolt_spacing/2, bolt_spacing/2])
    translate([jaw_width/2 + x, 0, jaw_height/2])
        nut();
```

