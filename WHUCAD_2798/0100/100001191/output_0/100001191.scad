
// Dimensions
base_length = 40;
base_width = 20;
base_height = 20;

wedge_length = base_length;
wedge_height = 20;

// Main block
difference() {
    // Base rectangular block
    cube([base_length, base_width, base_height]);

    // Wedge cut
    translate([0, 0, base_height])
        rotate([0, 90, 0])
            linear_extrude(height = base_length)
                polygon(points=[[0,0], [base_width,0], [0,-wedge_height]]);
}

