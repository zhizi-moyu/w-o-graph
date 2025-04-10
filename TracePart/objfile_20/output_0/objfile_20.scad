```scad
// Parameters
shaft_d = 20;
shaft_l = 80;

hub_d = 30;
hub_l = 15;

flange_d = 40;
flange_t = 5;

spacer_t = 2;

bolt_d = 3;
bolt_l = 20;
bolt_head_d = 5;
bolt_head_h = 2;

nut_d = 5;
nut_h = 3;

bolt_circle_r = 15;
bolt_count = 4;

// Modules
module central_shaft() {
    cylinder(d=shaft_d, h=shaft_l, $fn=100);
}

module hub() {
    translate([0, 0, -hub_l])
        cylinder(d=hub_d, h=hub_l, $fn=100);
}

module flange_plate() {
    difference() {
        cylinder(d=flange_d, h=flange_t, $fn=100);
        cylinder(d=shaft_d, h=flange_t + 1, $fn=100);
        for (i = [0 : 360 / bolt_count : 360 - 360 / bolt_count]) {
            angle = i;
            x = bolt_circle_r * cos(angle);
            y = bolt_circle_r * sin(angle);
            translate([x, y, 0])
                cylinder(d=bolt_d + 1, h=flange_t + 1, $fn=50);
        }
    }
}

module spacer_ring() {
    difference() {
        cylinder(d=flange_d, h=spacer_t, $fn=100);
        cylinder(d=shaft_d, h=spacer_t + 1, $fn=100);
    }
}

module bolt() {
    union() {
        cylinder(d=bolt_d, h=bolt_l, $fn=50);
        translate([0, 0, bolt_l])
            cylinder(d=bolt_head_d, h=bolt_head_h, $fn=6);
    }
}

module nut() {
    cylinder(d=nut_d, h=nut_h, $fn=6);
}

module bolt_with_nut() {
    union() {
        bolt();
        translate([0, 0, -nut_h])
            nut();
    }
}

module flange_assembly() {
    union() {
        flange_plate();
        translate([0, 0, flange_t])
            spacer_ring();
        translate([0, 0, flange_t + spacer_t])
            flange_plate();
        for (i = [0 : 360 / bolt_count : 360 - 360 / bolt_count]) {
            angle = i;
            x = bolt_circle_r * cos(angle);
            y = bolt_circle_r * sin(angle);
            translate([x, y, flange_t])
                rotate([0, 0, 0])
                    bolt_with_nut();
        }
    }
}

// Assembly
module coupling() {
    union() {
        // Central shaft
        translate([0, 0, hub_l + flange_t + spacer_t + flange_t])
            central_shaft();

        // Input hub
        translate([0, 0, 0])
            hub();

        // Output hub
        translate([0, 0, hub_l + flange_t + spacer_t + flange_t + shaft_l])
            rotate([180, 0, 0])
                hub();

        // Left flange assembly
        translate([0, 0, hub_l])
            flange_assembly();

        // Right flange assembly
        translate([0, 0, hub_l + flange_t + spacer_t + flange_t + shaft_l])
            rotate([180, 0, 0])
                flange_assembly();
    }
}

// Render the model
coupling();
```

