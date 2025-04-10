```scad
// Parameters
hub_diameter = 30;
hub_length = 20;
bore_diameter = 10;
jaw_radius = 5;
jaw_depth = 5;
jaw_count = 3;
spider_arm_thickness = 4;
spider_arm_length = 6;
spider_radius = 12;
set_screw_diameter = 3;
set_screw_length = 8;

// Modules
module hub(mirror=false) {
    rotate([0, 0, mirror ? 180 : 0])
    difference() {
        union() {
            // Main hub body
            cylinder(d=hub_diameter, h=hub_length, $fn=100);
            
            // Jaws
            for (i = [0 : 360/jaw_count : 360 - 360/jaw_count]) {
                rotate([0, 0, i])
                translate([hub_diameter/2 - jaw_radius, 0, hub_length - jaw_depth])
                    cylinder(r=jaw_radius, h=jaw_depth, $fn=50);
            }
        }
        // Bore
        translate([0, 0, -1])
            cylinder(d=bore_diameter, h=hub_length + 2, $fn=100);
        
        // Set screw hole
        rotate([0, 90, 0])
        translate([-hub_length/2, 0, hub_diameter/4])
            cylinder(d=set_screw_diameter, h=hub_length, $fn=30);
    }
}

module elastomer_spider() {
    difference() {
        // Central disk
        cylinder(d=spider_radius*2, h=spider_arm_thickness, $fn=100);
        
        // Cutouts between arms
        for (i = [0 : 60 : 300]) {
            rotate([0, 0, i])
            translate([spider_radius, 0, -1])
                cube([spider_arm_length, spider_arm_length, spider_arm_thickness + 2], center=true);
        }
    }
}

module set_screw() {
    union() {
        // Screw body
        cylinder(d=set_screw_diameter, h=set_screw_length, $fn=30);
        // Hex socket
        translate([0, 0, set_screw_length - 2])
            cylinder(d=2.5, h=2, $fn=6);
    }
}

// Assembly
translate([0, 0, 0])
    hub(mirror=false);

translate([0, 0, hub_length])
    hub(mirror=true);

translate([0, 0, hub_length - spider_arm_thickness/2])
    elastomer_spider();

// Set screws
translate([-hub_length/2, hub_diameter/4, hub_length/2])
    rotate([0, 90, 0])
    set_screw();

translate([hub_length + hub_length/2, hub_diameter/4, hub_length/2])
    rotate([0, 90, 0])
    set_screw();
```

