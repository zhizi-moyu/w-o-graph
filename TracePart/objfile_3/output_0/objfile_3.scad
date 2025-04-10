
$fn = 100;

// Parameters
coupling_diameter = 20;
coupling_length = 20;
bore_diameter = 6;
slit_width = 1;
slit_depth = coupling_diameter / 2;
screw_hole_diameter = 3;
screw_head_diameter = 5;
screw_head_depth = 2;
tab_width = 4;
tab_height = 2;
tab_depth = 3;

// Modules
module slit() {
    translate([0, -slit_width/2, 0])
        cube([coupling_length, slit_width, slit_depth], center=false);
}

module screw_hole() {
    rotate([90, 0, 0])
        translate([0, 0, -coupling_diameter/2])
            cylinder(h=coupling_diameter, d=screw_hole_diameter, center=true);
}

module screw_head() {
    rotate([90, 0, 0])
        translate([0, 0, -screw_head_depth/2])
            cylinder(h=screw_head_depth, d=screw_head_diameter, center=true);
}

module clamping_screw() {
    union() {
        cylinder(h=6, d=screw_hole_diameter);
        translate([0, 0, 6])
            cylinder(h=2, d=screw_head_diameter);
    }
}

module left_coupling_half() {
    difference() {
        cylinder(h=coupling_length, d=coupling_diameter);
        // Bore
        translate([0, 0, -1])
            cylinder(h=coupling_length + 2, d=bore_diameter);
        // Slit
        translate([0, 0, 0])
            rotate([0, 0, 0])
                slit();
        // Screw holes
        translate([5, 0, coupling_length/3])
            screw_hole();
        translate([5, 0, 2*coupling_length/3])
            screw_hole();
        // Screw heads
        translate([5, 0, coupling_length/3])
            screw_head();
        translate([5, 0, 2*coupling_length/3])
            screw_head();
    }
}

module right_coupling_half() {
    difference() {
        union() {
            cylinder(h=coupling_length, d=coupling_diameter);
            // Tab
            translate([-tab_depth, -tab_width/2, coupling_length])
                cube([tab_depth, tab_width, tab_height]);
        }
        // Bore
        translate([0, 0, -1])
            cylinder(h=coupling_length + 2, d=bore_diameter);
        // Slit
        translate([0, 0, 0])
            rotate([0, 0, 0])
                slit();
        // Screw holes
        translate([5, 0, coupling_length/3])
            screw_hole();
        translate([5, 0, 2*coupling_length/3])
            screw_hole();
        // Screw heads
        translate([5, 0, coupling_length/3])
            screw_head();
        translate([5, 0, 2*coupling_length/3])
            screw_head();
        // Slot for tab
        translate([0, -tab_width/2, coupling_length - tab_height])
            cube([tab_depth, tab_width, tab_height + 1]);
    }
}

// Assembly
translate([0, 0, 0])
    left_coupling_half();

translate([0, 0, coupling_length])
    right_coupling_half();

// Screws (simplified)
translate([5, 0, coupling_length/3])
    clamping_screw();

translate([5, 0, 2*coupling_length/3])
    clamping_screw();

translate([5, 0, coupling_length + coupling_length/3])
    clamping_screw();

translate([5, 0, coupling_length + 2*coupling_length/3])
    clamping_screw();

