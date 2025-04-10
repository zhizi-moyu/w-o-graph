```scad
$fn = 100; // Smoothness

// Parameters
shaft_d = 20;
shaft_l = 40;
flange_d = 40;
flange_t = 10;
center_hole_d = 8;
bolt_hole_d = 4;
bolt_circle_d = 30;
bolt_num = 6;
spacer_t = 2;
flange_plate_t = 6;
bolt_l = flange_plate_t*2 + spacer_t*2 + 2;
bolt_head_d = 6;
nut_d = 6;
nut_t = 4;

// Modules
module shaft_with_flange() {
    union() {
        // Shaft
        cylinder(d=shaft_d, h=shaft_l);
        // Flange
        translate([0, 0, shaft_l])
            difference() {
                cylinder(d=flange_d, h=flange_t);
                // Center hole
                cylinder(d=center_hole_d, h=flange_t + 1);
                // Bolt holes
                for (i = [0 : 360/bolt_num : 360 - 360/bolt_num]) {
                    angle = i;
                    x = bolt_circle_d/2 * cos(angle);
                    y = bolt_circle_d/2 * sin(angle);
                    translate([x, y, 0])
                        cylinder(d=bolt_hole_d, h=flange_t + 1);
                }
            }
    }
}

module flange_plate() {
    difference() {
        cylinder(d=flange_d, h=flange_plate_t);
        // Center hole
        cylinder(d=center_hole_d, h=flange_plate_t + 1);
        // Bolt holes
        for (i = [0 : 360/bolt_num : 360 - 360/bolt_num]) {
            angle = i;
            x = bolt_circle_d/2 * cos(angle);
            y = bolt_circle_d/2 * sin(angle);
            translate([x, y, 0])
                cylinder(d=bolt_hole_d, h=flange_plate_t + 1);
        }
    }
}

module spacer_ring() {
    difference() {
        cylinder(d=flange_d, h=spacer_t);
        cylinder(d=center_hole_d, h=spacer_t + 1);
        for (i = [0 : 360/bolt_num : 360 - 360/bolt_num]) {
            angle = i;
            x = bolt_circle_d/2 * cos(angle);
            y = bolt_circle_d/2 * sin(angle);
            translate([x, y, 0])
                cylinder(d=bolt_hole_d, h=spacer_t + 1);
        }
    }
}

module bolt() {
    union() {
        // Shaft
        cylinder(d=bolt_hole_d, h=bolt_l);
        // Head
        translate([0, 0, bolt_l])
            cylinder(d=bolt_head_d, h=2);
    }
}

module nut() {
    cylinder(d=nut_d, h=nut_t);
}

// Assembly
module coupling() {
    // Input shaft
    shaft_with_flange();

    // Output shaft
    translate([0, 0, shaft_l + flange_t + flange_plate_t*2 + spacer_t*2])
        rotate([180, 0, 0])
            shaft_with_flange();

    // Flange plates
    translate([0, 0, shaft_l])
        flange_plate();
    translate([0, 0, shaft_l + flange_plate_t + spacer_t])
        flange_plate();

    // Spacer rings
    translate([0, 0, shaft_l + flange_plate_t])
        spacer_ring();
    translate([0, 0, shaft_l + flange_plate_t + spacer_t + flange_plate_t])
        spacer_ring();

    // Bolts and nuts
    for (i = [0 : 360/bolt_num : 360 - 360/bolt_num]) {
        angle = i;
        x = bolt_circle_d/2 * cos(angle);
        y = bolt_circle_d/2 * sin(angle);
        translate([x, y, shaft_l - 1])
            bolt();
        translate([x, y, shaft_l + flange_plate_t*2 + spacer_t*2 + 1])
            nut();
    }
}

coupling();
```

