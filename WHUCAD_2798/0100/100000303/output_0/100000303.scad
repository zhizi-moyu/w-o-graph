
// Parameters
frame_length = 100;
frame_width = 60;
frame_thickness = 3;
cutout_length = 60;
cutout_width = 40;
slot_width = 10;
slot_length = 20;
bracket_height = 25;
bracket_base = 30;
bracket_thickness = 3;
rib_thickness = 3;
rib_height = 25;
rib_width = 5;
rib_slot_height = 10;
rib_slot_width = 2;

// Base Frame
module base_frame() {
    difference() {
        cube([frame_length, frame_width, frame_thickness]);
        translate([(frame_length - cutout_length)/2, (frame_width - cutout_width)/2, 0])
            cube([cutout_length, cutout_width, frame_thickness + 1]);
        // Left slot
        translate([5, (frame_width - slot_width)/2, 0])
            cube([slot_length, slot_width, frame_thickness + 1]);
        // Right slot
        translate([frame_length - slot_length - 5, (frame_width - slot_width)/2, 0])
            cube([slot_length, slot_width, frame_thickness + 1]);
    }
}

// Sloped Support Bracket
module sloped_support_bracket(mirrorX = false) {
    translate([mirrorX ? frame_length - bracket_base : 0, 0, frame_thickness]) {
        rotate([0, 0, mirrorX ? 180 : 0])
        linear_extrude(height = bracket_thickness)
        polygon(points=[[0,0], [bracket_base,0], [0,bracket_height]]);
    }
}

// Vertical Support Rib
module vertical_support_rib() {
    translate([(frame_length - rib_thickness)/2, (frame_width - rib_width)/2, frame_thickness])
        difference() {
            cube([rib_thickness, rib_width, rib_height]);
            translate([0, (rib_width - rib_slot_width)/2, rib_height/2 - rib_slot_height/2])
                cube([rib_thickness + 1, rib_slot_width, rib_slot_height]);
        }
}

// Assembly
module assembly() {
    base_frame();
    sloped_support_bracket(false);
    sloped_support_bracket(true);
    vertical_support_rib();
}

assembly();

