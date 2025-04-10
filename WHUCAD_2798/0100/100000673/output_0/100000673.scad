
// Locking Key Parameters
thickness = 2; // Thickness of the key (extrusion depth)

// 2D profile of the locking key
module locking_key_profile() {
    polygon(points=[
        [0, 0],         // Start at origin
        [5, 0],         // Right edge
        [7, 2],         // Angled edge
        [10, 10],       // Tapered sharp end
        [5, 12],        // Top angled edge
        [3, 14],        // Top left
        [1, 14],        // Start of semicircle
        [-1, 12],       // Left curve
        [-1.5, 10],     // Bottom of semicircle
        [-1, 8],        // Curve up
        [0, 6]          // Connect back to origin
    ]);
}

// Extrude the 2D profile to 3D
module locking_key() {
    linear_extrude(height=thickness)
        locking_key_profile();
}

// Render the locking key
locking_key();

