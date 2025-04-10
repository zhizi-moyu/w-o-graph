
// Parameters
plate_size = 40;         // Width and height of the square plate
plate_thickness = 2;     // Thickness of the plate
corner_radius = 2;       // Radius for rounded corners
hole_diameter = 5;       // Diameter of the central hole

module square_plate() {
    difference() {
        // Rounded square plate
        minkowski() {
            cube([plate_size - 2*corner_radius, plate_size - 2*corner_radius, plate_thickness], center=true);
            cylinder(r=corner_radius, h=0.01, center=true);
        }
        // Central hole
        translate([0, 0, -1])
            cylinder(d=hole_diameter, h=plate_thickness + 2, center=true);
    }
}

// Render one plate
square_plate();

// To render all 6 plates stacked (optional):
// for (i = [0:5]) {
//     translate([0, 0, i * (plate_thickness + 0.5)])
//         square_plate();
// }

