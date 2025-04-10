```scad
// Parameters
hub_diameter = 30;
hub_length = 25;
bore_diameter = 10;
flange_diameter = 40;
flange_thickness = 5;
bolt_hole_diameter = 3;
bolt_circle_diameter = 32;
num_bolts = 6;
bellows_length = 20;
bellows_outer_diameter = 25;
bellows_inner_diameter = 15;
bellows_ridges = 5;
slit_width = 1;
set_screw_diameter = 2;

// Modules
module shaft_hub() {
    difference() {
        union() {
            // Main hub body
            cylinder(d=hub_diameter, h=hub_length);
            // Flange
            translate([0, 0, hub_length])
                cylinder(d=flange_diameter, h=flange_thickness);
        }
        // Bore
        translate([0, 0, -1])
            cylinder(d=bore_diameter, h=hub_length + flange_thickness + 2);
        // Slit
        translate([-slit_width/2, -hub_diameter/2, 0])
            cube([slit_width, hub_diameter, hub_length]);
        // Set screw hole
        rotate([90, 0, 0])
            translate([-hub_length/2, 0, hub_diameter/2 - 2])
                cylinder(d=set_screw_diameter, h=hub_length + 2, center=true);
        // Bolt holes in flange
        for (i = [0 : 360/num_bolts : 360 - 360/num_bolts]) {
            angle = i;
            x = bolt_circle_diameter/2 * cos(angle);
            y = bolt_circle_diameter/2 * sin(angle);
            translate([x, y, hub_length + flange_thickness/2])
                rotate([90, 0, 0])
                    cylinder(d=bolt_hole_diameter, h=flange_thickness + 2, center=true);
        }
    }
}

module bellows() {
    translate([0, 0, hub_length + flange_thickness])
        difference() {
            cylinder(d=bellows_outer_diameter, h=bellows_length);
            translate([0, 0, -1])
                cylinder(d=bellows_inner_diameter, h=bellows_length + 2);
        }
}

module flange_ring() {
    difference() {
        cylinder(d=flange_diameter, h=flange_thickness);
        // Center hole
        cylinder(d=bellows_inner_diameter, h=flange_thickness + 1);
        // Bolt holes
        for (i = [0 : 360/num_bolts : 360 - 360/num_bolts]) {
            angle = i;
            x = bolt_circle_diameter/2 * cos(angle);
            y = bolt_circle_diameter/2 * sin(angle);
            translate([x, y, 0])
                cylinder(d=bolt_hole_diameter, h=flange_thickness + 1);
        }
    }
}

module bolt() {
    union() {
        // Shaft
        cylinder(d=bolt_hole_diameter, h=flange_thickness + 2);
        // Head
        translate([0, 0, flange_thickness + 2])
            cylinder(d=bolt_hole_diameter * 1.5, h=2);
    }
}

module nut() {
    cylinder(d=bolt_hole_diameter * 1.5, h=2);
}

// Assembly
module coupling() {
    // Input hub
    shaft_hub();
    // Output hub (mirrored)
    translate([0, 0, hub_length + flange_thickness + bellows_length])
        rotate([180, 0, 0])
            shaft_hub();
    // Bellows
    bellows();
    // Flange rings
    translate([0, 0, hub_length])
        flange_ring();
    translate([0, 0, hub_length + flange_thickness + bellows_length])
        flange_ring();
    // Bolts and nuts
    for (i = [0 : 360/num_bolts : 360 - 360/num_bolts]) {
        angle = i;
        x = bolt_circle_diameter/2 * cos(angle);
        y = bolt_circle_diameter/2 * sin(angle);
        // Bolts
        translate([x, y, hub_length])
            bolt();
        // Nuts
        translate([x, y, hub_length + flange_thickness + bellows_length + flange_thickness])
            nut();
    }
}

// Render the full coupling
coupling();
```

