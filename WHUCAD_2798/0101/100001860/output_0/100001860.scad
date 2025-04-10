
// Parameters
radius = 30;     // Outer radius of the wedge
height = 20;     // Height of the wedge
angle = 60;      // Angle of the wedge segment (360 / 6)

// Module to create a single wedge segment
module wedge_segment() {
    rotate_extrude(angle=angle)
        translate([radius, 0, 0])
            square([0.01, height], center=false); // Thin rectangle to extrude
}

// Render the wedge
wedge_segment();

