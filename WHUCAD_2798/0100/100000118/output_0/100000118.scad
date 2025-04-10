
// Parameters
outer_size = 40;     // Outer box width and depth
height = 20;         // Height of the box
wall_thickness = 2;  // Thickness of the outer wall

module sloped_inner_box() {
    difference() {
        // Outer box
        cube([outer_size, outer_size, height]);

        // Inner cavity
        translate([wall_thickness, wall_thickness, 0])
        polyhedron(
            points=[
                [0, 0, 0],                                // 0: bottom corner
                [outer_size - 2*wall_thickness, 0, 0],    // 1: bottom front right
                [outer_size - 2*wall_thickness, outer_size - 2*wall_thickness, 0], // 2: bottom back right
                [0, outer_size - 2*wall_thickness, 0],    // 3: bottom back left
                [0, 0, height - wall_thickness]           // 4: top corner (sloped)
            ],
            faces=[
                [0, 1, 2, 3],  // bottom face
                [0, 1, 4],     // sloped triangle face
                [1, 2, 4],     // right wall
                [2, 3, 4],     // back wall
                [3, 0, 4]      // left wall
            ]
        );
    }
}

// Render the model
sloped_inner_box();

