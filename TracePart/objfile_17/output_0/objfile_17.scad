
$fn = 100;

// Parameters
hub_d = 30;
hub_l = 40;
bore_d = 10;
flange_d = 50;
flange_t = 5;
spacer_t = 1;
bolt_d = 3;
bolt_l = 20;
bolt_circle_d = 40;
num_bolts = 4;
nut_flat = 6;
nut_thick = 3;

// Modules
module shaft_hub() {
    difference() {
        cylinder(d=hub_d, h=hub_l);
        translate([0, 0, -1])
            cylinder(d=bore_d, h=hub_l + 2);
    }
}

module flange_plate() {
    difference() {
        cylinder(d=flange_d, h=flange_t);
        for (i = [0 : 360/num_bolts : 360 - 360/num_bolts]) {
            angle = i;
            x = bolt_circle_d/2 * cos(angle);
            y = bolt_circle_d/2 * sin(angle);
            translate([x, y, -1])
                cylinder(d=bolt_d + 1, h=flange_t + 2);
        }
    }
}

module spacer_ring() {
    difference() {
        cylinder(d=flange_d, h=spacer_t);
        cylinder(d=flange_d - 10, h=spacer_t + 1);
    }
}

module bolt() {
    cylinder(d=bolt_d, h=bolt_l);
}

module nut() {
    rotate([0, 0, 30])
        linear_extrude(height=nut_thick)
            offset(r=0.5)
                circle(d=nut_flat, $fn=6);
}

// Assembly
module coupling() {
    // Left hub
    translate([0, 0, 0])
        shaft_hub();

    // Right hub
    translate([0, 0, hub_l + 2 * flange_t + 2 * spacer_t])
        shaft_hub();

    // Left flange
    translate([0, 0, hub_l])
        flange_plate();

    // Right flange
    translate([0, 0, hub_l + 2 * spacer_t + flange_t])
        flange_plate();

    // Spacer rings
    translate([0, 0, hub_l + flange_t])
        spacer_ring();
    translate([0, 0, hub_l + flange_t + spacer_t])
        spacer_ring();

    // Bolts and nuts
    for (i = [0 : 360/num_bolts : 360 - 360/num_bolts]) {
        angle = i;
        x = bolt_circle_d/2 * cos(angle);
        y = bolt_circle_d/2 * sin(angle);
        // Bolt
        translate([x, y, hub_l - 2])
            bolt();
        // Nut
        translate([x, y, hub_l + 2 * flange_t + 2 * spacer_t])
            nut();
    }
}

coupling();

