
// Parameters
tabletop_length = 100;
tabletop_width = 60;
tabletop_thickness = 5;

leg_diameter = 4;
leg_height = 60;

support_bar_thickness = 2;
support_bar_length = 80;

// Modules
module tabletop() {
    cube([tabletop_length, tabletop_width, tabletop_thickness], center = true);
}

module table_leg() {
    cylinder(h = leg_height, d = leg_diameter, center = false);
}

module support_bar() {
    cube([support_bar_length, support_bar_thickness, support_bar_thickness], center = true);
}

// Assembly
translate([0, 0, leg_height + tabletop_thickness/2])
    tabletop();

// Legs (4 attached, 1 detached)
leg_positions = [
    [-tabletop_length/2 + leg_diameter/2, -tabletop_width/2 + leg_diameter/2],
    [ tabletop_length/2 - leg_diameter/2, -tabletop_width/2 + leg_diameter/2],
    [-tabletop_length/2 + leg_diameter/2,  tabletop_width/2 - leg_diameter/2],
    [ tabletop_length/2 - leg_diameter/2,  tabletop_width/2 - leg_diameter/2]
];

for (pos in leg_positions)
    translate([pos[0], pos[1], 0])
        table_leg();

// Detached leg
translate([tabletop_length, 0, 0])
    table_leg();

// Support bars
translate([0, -tabletop_width/2 + leg_diameter, leg_height/2])
    rotate([0, 90, 0])
        support_bar();

translate([0, tabletop_width/2 - leg_diameter, leg_height/2])
    rotate([0, 90, 0])
        support_bar();

translate([0, 0, leg_height/2])
    rotate([90, 0, 0])
        support_bar();

