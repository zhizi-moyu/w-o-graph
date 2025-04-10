
$fn = 100; // Smoothness

// Parameters
coupling_diameter = 40;
coupling_length = 20;
bore_diameter = 10;
slot_width = 6;
slot_depth = 6;
slot_height = 10;
spider_thickness = 6;
spider_lobe_radius = 6;

// Main Assembly
module coupling_half(mirror=false) {
    difference() {
        // Main body
        cylinder(d=coupling_diameter, h=coupling_length);

        // Bore hole
        translate([0, 0, -1])
            cylinder(d=bore_diameter, h=coupling_length + 2);

        // Slots
        for (i = [0:2]) {
            angle = i * 120;
            rotate([0, 0, angle])
                translate([coupling_diameter/2 - slot_depth, -slot_width/2, coupling_length - slot_height])
                    cube([slot_depth, slot_width, slot_height]);
        }
    }
}

// Central Spider
module central_spider() {
    difference() {
        union() {
            for (i = [0:2]) {
                rotate([0, 0, i * 120])
                    translate([spider_lobe_radius, 0, 0])
                        cylinder(r=spider_lobe_radius, h=spider_thickness);
            }
        }
        // Trim bottom and top to make it flat
        translate([-20, -20, -1])
            cube([40, 40, 1]);
        translate([-20, -20, spider_thickness])
            cube([40, 40, 1]);
    }
}

// Assembly
translate([0, 0, 0])
    coupling_half();

translate([0, 0, coupling_length])
    mirror([0, 0, 1])
        coupling_half();

translate([0, 0, coupling_length - spider_thickness/2])
    central_spider();

