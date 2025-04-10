
// Module to create a spacer ring
module spacer_ring(outer_d=30, inner_d=15, height=5) {
    difference() {
        cylinder(d=outer_d, h=height, $fn=100);
        translate([0, 0, -1])  // Slightly lower to ensure clean subtraction
            cylinder(d=inner_d, h=height + 2, $fn=100);
    }
}

// Create 6 spacer rings (stacked vertically for visualization)
for (i = [0:5]) {
    translate([0, 0, i * 6])  // 1 mm gap between each ring
        spacer_ring();
}

