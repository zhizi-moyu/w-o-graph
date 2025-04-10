
$fn = 100; // Smoothness

// Parameters
shaft_d = 20;
shaft_l = 30;
bore_d = 8;

flange_d = 50;
flange_t = 5;
bolt_hole_d = 5;
bolt_circle_d = 40;

spacer_t = 2;
spacer_d = flange_d;

bolt_d = 5;
bolt_l = 20;
nut_d = 8;
nut_h = 4;

// Modules
module shaft() {
    difference() {
        cylinder(d=shaft_d, h=shaft_l);
        translate([0, 0, -1])
            cylinder(d=bore_d, h=shaft_l + 2);
    }
}

module flange_plate() {
    difference() {
        cylinder(d=flange_d, h=flange_t);
        for (i = [0:5]) {
            angle = i * 360 / 6;
            translate([bolt_circle_d/2 * cos(angle), bolt_circle_d/2 * sin(angle), 0])
                cylinder(d=bolt_hole_d, h=flange_t + 1);
        }
    }
}

module spacer_ring() {
    difference() {
        cylinder(d=spacer_d, h=spacer_t);
        cylinder(d=bolt_circle_d - 10, h=spacer_t + 1);
    }
}

module bolt() {
    union() {
        cylinder(d=bolt_d, h=bolt_l);
        translate([0, 0, bolt_l])
            cylinder(d=bolt_d * 1.5, h=2); // hex head approximation
    }
}

module nut() {
    cylinder(d=nut_d, h=nut_h);
}

// Assembly
module coupling() {
    // Input shaft
    translate([0, 0, 0])
        shaft();

    // Output shaft
    translate([0, 0, shaft_l + 2 * flange_t + 2 * spacer_t])
        shaft();

    // Flange plates
    translate([0, 0, shaft_l])
        flange_plate();

    translate([0, 0, shaft_l + flange_t + 2 * spacer_t])
        flange_plate();

    // Spacer rings
    translate([0, 0, shaft_l + flange_t])
        spacer_ring();

    translate([0, 0, shaft_l + flange_t + spacer_t])
        spacer_ring();

    // Bolts and nuts
    for (i = [0:5]) {
        angle = i * 360 / 6;
        x = bolt_circle_d/2 * cos(angle);
        y = bolt_circle_d/2 * sin(angle);
        // Bolt
        translate([x, y, shaft_l - 2])
            bolt();
        // Nut
        translate([x, y, shaft_l + flange_t + 2 * spacer_t + flange_t])
            nut();
    }
}

// Render the full coupling
coupling();
