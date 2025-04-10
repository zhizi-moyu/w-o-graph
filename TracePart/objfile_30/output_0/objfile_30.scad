```scad
$fn = 100;

// Parameters
hub_d = 30;
hub_l = 20;
bore_d = 10;

bellows_d = 28;
bellows_l = 30;
bellows_ridges = 6;
ridge_depth = 2;
ridge_spacing = 4;

plate_d = 34;
plate_th = 4;
bolt_d = 3;
bolt_spacing = 12;

bolt_head_d = 5;
bolt_head_h = 2;
nut_d = 5;
nut_h = 2;

// Modules
module shaft_hub() {
    difference() {
        cylinder(d=hub_d, h=hub_l);
        translate([0, 0, -1])
            cylinder(d=bore_d, h=hub_l + 2);
    }
}

module bellows() {
    for (i = [0:bellows_ridges - 1]) {
        translate([0, 0, i * ridge_spacing])
            cylinder(d=bellows_d + ridge_depth * sin(i * 180), h=ridge_spacing / 2);
    }
}

module clamp_plate() {
    difference() {
        cylinder(d=plate_d, h=plate_th);
        translate([0, 0, -1])
            cylinder(d=bore_d, h=plate_th + 2);
        for (i = [0:2]) {
            angle = i * 120;
            translate([bolt_spacing * cos(angle), bolt_spacing * sin(angle), -1])
                cylinder(d=bolt_d, h=plate_th + 2);
        }
    }
}

module hex_bolt() {
    union() {
        cylinder(d=bolt_d, h=plate_th + 2);
        translate([0, 0, plate_th + 2])
            cylinder(d=bolt_head_d, h=bolt_head_h, $fn=6);
    }
}

module hex_nut() {
    cylinder(d=nut_d, h=nut_h, $fn=6);
}

// Assembly
module coupling() {
    // Left hub
    translate([0, 0, 0])
        shaft_hub();

    // Right hub
    translate([0, 0, hub_l + bellows_l + 2 * plate_th])
        shaft_hub();

    // Bellows
    translate([0, 0, hub_l + plate_th])
        bellows();

    // Left clamp plate
    translate([0, 0, hub_l])
        clamp_plate();

    // Right clamp plate
    translate([0, 0, hub_l + bellows_l + plate_th])
        clamp_plate();

    // Bolts and nuts (3 on each side)
    for (i = [0:2]) {
        angle = i * 120;
        x = bolt_spacing * cos(angle);
        y = bolt_spacing * sin(angle);

        // Left side bolts
        translate([x, y, hub_l + plate_th])
            hex_bolt();

        // Right side bolts
        translate([x, y, hub_l + bellows_l + plate_th * 2])
            hex_bolt();

        // Left side nuts
        translate([x, y, hub_l - nut_h])
            hex_nut();

        // Right side nuts
        translate([x, y, hub_l + bellows_l + plate_th * 2 + bolt_head_h + plate_th])
            hex_nut();
    }
}

coupling();
```

