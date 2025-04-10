
$fn = 100; // Smoothness

// Parameters
hub_d = 30;
hub_l = 25;
bore_d = 10;
flange_d = 50;
flange_t = 5;
bolt_d = 4;
bolt_spacing = 20;
flex_thickness = 3;
flex_d = 45;
nut_d = 7;
nut_h = 3;

// Modules
module shaft_hub() {
    difference() {
        union() {
            cylinder(d=hub_d, h=hub_l);
            translate([0, 0, hub_l - flange_t])
                cylinder(d=flange_d, h=flange_t);
        }
        // Bore
        translate([0, 0, -1])
            cylinder(d=bore_d, h=hub_l + 2);
        // Side hole
        translate([-hub_d/2, 0, hub_l/2])
            rotate([0,90,0])
                cylinder(d=bolt_d, h=hub_d);
    }
}

module flange_plate() {
    difference() {
        cylinder(d=flange_d, h=flange_t);
        for (i = [0:90:270]) {
            angle = i;
            x = bolt_spacing * cos(angle);
            y = bolt_spacing * sin(angle);
            translate([x, y, -1])
                cylinder(d=bolt_d, h=flange_t + 2);
        }
    }
}

module bolt() {
    union() {
        cylinder(d=bolt_d, h=flange_t*2 + flex_thickness + 2);
        translate([0, 0, flange_t*2 + flex_thickness + 2])
            cylinder(d=bolt_d*1.5, h=2); // hex head
    }
}

module nut() {
    cylinder(d=nut_d, h=nut_h);
}

module flexible_element() {
    // Simplified as a thin disk with holes
    difference() {
        cylinder(d=flex_d, h=flex_thickness);
        for (i = [0:90:270]) {
            angle = i;
            x = bolt_spacing * cos(angle);
            y = bolt_spacing * sin(angle);
            translate([x, y, -1])
                cylinder(d=bolt_d, h=flex_thickness + 2);
        }
    }
}

// Assembly
module coupling() {
    // Input hub
    translate([0, 0, 0])
        shaft_hub();

    // Output hub (mirrored)
    translate([0, 0, hub_l + flange_t*2 + flex_thickness])
        rotate([180, 0, 0])
            shaft_hub();

    // Flange plates
    translate([0, 0, hub_l - flange_t])
        flange_plate();

    translate([0, 0, hub_l + flex_thickness])
        flange_plate();

    // Flexible element
    translate([0, 0, hub_l])
        flexible_element();

    // Bolts and nuts
    for (i = [0:90:270]) {
        angle = i;
        x = bolt_spacing * cos(angle);
        y = bolt_spacing * sin(angle);
        // Bolts
        translate([x, y, hub_l - flange_t])
            bolt();
        // Nuts
        translate([x, y, hub_l + flange_t*2 + flex_thickness + 2])
            nut();
    }
}

coupling();

