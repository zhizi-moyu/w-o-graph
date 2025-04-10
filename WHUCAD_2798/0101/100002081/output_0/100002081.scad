
// Parameters
block_width = 40;
block_depth = 40;
block_height = 30;

pyramid_base = 10;
pyramid_height = 10;
spacing = 10;

// Create the main block
difference() {
    cube([block_width, block_depth, block_height], center = false);

    // Create 4 inverted pyramidal recesses
    for (x = [0:1]) {
        for (y = [0:1]) {
            translate([
                x * (pyramid_base + spacing) + (block_width - 2 * pyramid_base - spacing) / 2,
                y * (pyramid_base + spacing) + (block_depth - 2 * pyramid_base - spacing) / 2,
                block_height - pyramid_height
            ])
            rotate([0, 0, 0])
            pyramid(pyramid_base, pyramid_height);
        }
    }
}

// Module to create an inverted square pyramid
module pyramid(base, height) {
    polyhedron(
        points=[
            [0, 0, 0],
            [base, 0, 0],
            [base, base, 0],
            [0, base, 0],
            [base/2, base/2, -height]
        ],
        faces=[
            [0, 1, 4],
            [1, 2, 4],
            [2, 3, 4],
            [3, 0, 4],
            [0, 1, 2, 3]
        ]
    );
}

