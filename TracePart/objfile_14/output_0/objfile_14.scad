```scad
$fn = 100;

// Parameters
hub_diameter = 40;
hub_length = 20;
bore_diameter = 10;
jaw_width = 8;
jaw_length = 10;
jaw_height = 10;
spider_thickness = 10;
pin_diameter = 3;
pin_length = 50;
pin_offset = 6;

// Modules
module hub(is_input=true) {
    difference() {
        cylinder(d=hub_diameter, h=hub_length);
        translate([0, 0, -1])
            cylinder(d=bore_diameter, h=hub_length + 2);
        // Threaded holes
        for (i = [0, 180]) {
            rotate([0, 0, i])
                translate([hub_diameter/3, 0, hub_length/2])
                    rotate([90, 0, 0])
                        cylinder(d=2, h=5);
        }
    }

    // Jaws
    for (i = [0:2]) {
        rotate([0, 0, i * 120])
            translate([hub_diameter/2 - jaw_width/2, -jaw_width/2, hub_length])
                cube([jaw_width, jaw_width, jaw_height]);
    }
}

module spider_insert() {
    for (i = [0:5]) {
        rotate([0, 0, i * 60])
            translate([hub_diameter/2 - jaw_width, -jaw_width/2, 0])
                cube([jaw_width, jaw_width, spider_thickness]);
    }
}

module pin() {
    cylinder(d=pin_diameter, h=pin_length);
}

// Assembly
module coupling() {
    // Input hub
    translate([0, 0, 0])
        hub(true);

    // Output hub
    translate([0, 0, hub_length + spider_thickness])
        mirror([0, 0, 1])
            hub(false);

    // Spider insert
    translate([0, 0, hub_length])
        spider_insert();

    // Pins
    for (i = [0, 180]) {
        rotate([0, 0, i])
            translate([pin_offset, 0, hub_length/2])
                rotate([90, 0, 0])
                    pin();
    }
}

coupling();
```

