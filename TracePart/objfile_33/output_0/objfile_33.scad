```scad
$fn=100;

// Parameters
hub_diameter = 40;
hub_length = 20;
flange_thickness = 5;
bore_diameter = 10;
bolt_hole_diameter = 4;
bolt_circle_radius = 15;
cutout_radius = 5;
cutout_depth = 5;
spider_arm_length = 10;
spider_arm_width = 6;
spider_thickness = 10;
bolt_length = 30;
bolt_head_diameter = 7;
nut_diameter = 7;
nut_thickness = 3;

// Modules
module hub(mirror=false) {
    rotate([0,0,mirror ? 180 : 0])
    union() {
        // Main body
        cylinder(d=hub_diameter, h=hub_length);
        
        // Flange
        translate([0,0,hub_length])
            cylinder(d=hub_diameter + 10, h=flange_thickness);
        
        // Bore
        translate([0,0,-1])
            cylinder(d=bore_diameter, h=hub_length + flange_thickness + 2);
        
        // Bolt holes
        for (i = [0:120:360]) {
            angle = i;
            x = bolt_circle_radius * cos(angle);
            y = bolt_circle_radius * sin(angle);
            translate([x, y, hub_length])
                cylinder(d=bolt_hole_diameter, h=flange_thickness + 1);
        }

        // Curved cutouts
        for (i = [0:120:360]) {
            angle = i;
            x = (hub_diameter/2 - cutout_radius) * cos(angle);
            y = (hub_diameter/2 - cutout_radius) * sin(angle);
            translate([x, y, hub_length - cutout_depth])
                rotate([0,0,angle])
                    cube([cutout_radius*2, cutout_radius, cutout_depth*2], center=true);
        }
    }
}

module spider() {
    union() {
        for (i = [0:60:360]) {
            angle = i;
            rotate([0,0,angle])
                translate([hub_diameter/2, -spider_arm_width/2, 0])
                    cube([spider_arm_length, spider_arm_width, spider_thickness]);
        }
    }
}

module bolt() {
    union() {
        // Shaft
        cylinder(d=bolt_hole_diameter, h=bolt_length);
        // Head
        translate([0,0,bolt_length])
            cylinder(d=bolt_head_diameter, h=3);
    }
}

module nut() {
    cylinder(d=nut_diameter, h=nut_thickness);
}

// Assembly
translate([0,0,0])
    hub(mirror=false);

translate([0,0,hub_length + flange_thickness + spider_thickness])
    hub(mirror=true);

translate([0,0,hub_length + flange_thickness])
    spider();

for (i = [0:120:360]) {
    angle = i;
    x = bolt_circle_radius * cos(angle);
    y = bolt_circle_radius * sin(angle);
    
    // Bolts
    translate([x, y, hub_length + flange_thickness])
        bolt();
    
    // Nuts
    translate([x, y, hub_length - nut_thickness])
        nut();
}
```

