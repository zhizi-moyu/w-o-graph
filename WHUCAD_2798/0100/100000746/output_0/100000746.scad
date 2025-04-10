
// Parameters
frame_width = 30;       // Width of the U-shape (horizontal span)
frame_height = 40;      // Total height of the U-shape
thickness = 2;          // Thickness of the frame (cross-section width)
depth = 4;              // Depth of the extrusion (3D thickness)

// Module to create a U-shaped frame
module u_shaped_frame() {
    difference() {
        // Outer shape
        linear_extrude(height = depth)
            offset(r = thickness)
                offset(delta = -thickness)
                    union() {
                        square([frame_width, frame_height - frame_width/2], center = false);
                        translate([0, frame_height - frame_width])
                            circle(r = frame_width/2, $fn = 50);
                    }

        // Inner cutout
        translate([thickness, thickness, -1])
            linear_extrude(height = depth + 2)
                union() {
                    square([frame_width - 2*thickness, frame_height - frame_width/2 - 2*thickness], center = false);
                    translate([0, frame_height - frame_width])
                        circle(r = (frame_width/2) - thickness, $fn = 50);
                }
    }
}

// Render the frame
u_shaped_frame();

