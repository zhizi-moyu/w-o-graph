
// Parameters
outer_length = 60;
outer_width = 30;
outer_height = 40;
wall_thickness = 3;
flange_thickness = 2;
flange_extension = 5;

// Main outer block
module outer_block() {
    cube([outer_length, outer_width, outer_height], center = true);
}

// Tapered inner cavity
module tapered_cavity() {
    top_length = outer_length - 2 * wall_thickness;
    top_width = outer_width - 2 * wall_thickness;
    bottom_length = top_length * 0.6;
    bottom_width = top_width * 0.6;
    height = outer_height;

    polyhedron(
        points = [
            // Top face (larger)
            [ -top_length/2, -top_width/2, height/2],
            [  top_length/2, -top_width/2, height/2],
            [  top_length/2,  top_width/2, height/2],
            [ -top_length/2,  top_width/2, height/2],
            // Bottom face (smaller)
            [ -bottom_length/2, -bottom_width/2, -height/2],
            [  bottom_length/2, -bottom_width/2, -height/2],
            [  bottom_length/2,  bottom_width/2, -height/2],
            [ -bottom_length/2,  bottom_width/2, -height/2]
        ],
        faces = [
            [0,1,2,3], // top
            [4,5,6,7], // bottom
            [0,1,5,4], // side
            [1,2,6,5],
            [2,3,7,6],
            [3,0,4,7]
        ]
    );
}

// Flanges
module flanges() {
    // Top flange
    translate([0, 0, outer_height/2])
        cube([outer_length + 2*flange_extension, outer_width + 2*flange_extension, flange_thickness], center = true);
    // Bottom flange
    translate([0, 0, -outer_height/2 - flange_thickness])
        cube([outer_length + 2*flange_extension, outer_width + 2*flange_extension, flange_thickness], center = true);
}

// Final model
difference() {
    union() {
        outer_block();
        flanges();
    }
    tapered_cavity();
}

