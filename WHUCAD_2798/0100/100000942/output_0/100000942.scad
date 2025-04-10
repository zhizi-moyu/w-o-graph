
// Parameters
block_length = 60;
block_width = 30;
block_height = 10;
hole_diameter = 6;
hole_offset_x = 15; // distance from center of hole to edge
corner_radius = 3;

// Main block with rounded edges
module rounded_block(length, width, height, radius) {
    minkowski() {
        cube([length - 2*radius, width - 2*radius, height], center=true);
        cylinder(r=radius, h=0.01, center=true);
    }
}

// Create the block
difference() {
    translate([0, 0, block_height/2])
        rounded_block(block_length, block_width, block_height, corner_radius);

    // Create two through holes
    for (x = [-block_length/2 + hole_offset_x, block_length/2 - hole_offset_x]) {
        translate([x, 0, 0])
            rotate([90, 0, 0])
                cylinder(h=block_height + 2, d=hole_diameter, center=true);
    }
}
