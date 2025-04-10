
// Dimensions
block_length = 40;
block_width = 30;
block_height = 20;
corner_radius = 4;

// Main block with sharp edges
difference() {
    // Base block
    cube([block_length, block_width, block_height]);

    // Subtract spheres from top corners to round them
    for (x = [0, block_length - corner_radius])
        for (y = [0, block_width - corner_radius])
            translate([x, y, block_height - corner_radius])
                rotate([0, 0, 0])
                    sphere(r = corner_radius, $fn=50);
}

