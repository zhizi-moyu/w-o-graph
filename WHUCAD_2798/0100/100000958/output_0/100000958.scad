
$fn=100;

// Parameters (adjust as needed)
cyl_d = 20;
cyl_h = 15;
flange_d = 30;
flange_h = 3;
slot_w = 5;
slot_d = 10;
center_hole_d = 5;
bore_d = 12;
recess_d = 14;
recess_h = 8;
cone_h = 10;
cone_d1 = 5;
cone_d2 = 10;

// 1. Slotted End Cap
module slotted_end_cap() {
    difference() {
        union() {
            cylinder(h=cyl_h, d=cyl_d);
            translate([0,0,cyl_h])
                cylinder(h=flange_h, d=flange_d);
        }
        // Slots
        for (i = [0, 180]) {
            rotate([0,0,i])
                translate([-slot_w/2, -cyl_d/2, 0])
                    cube([slot_w, cyl_d, slot_d]);
        }
        // Center hole
        translate([0,0,cyl_h + flange_h/2])
            cylinder(h=flange_h+1, d=center_hole_d, center=true);
    }
}

// 2. Slotted Cylinder with Flange
module slotted_cylinder_with_flange() {
    difference() {
        union() {
            cylinder(h=cyl_h, d=cyl_d);
            translate([0,0,cyl_h])
                cylinder(h=flange_h, d=flange_d);
        }
        // Hollow bore
        translate([0,0,-1])
            cylinder(h=cyl_h+flange_h+2, d=bore_d);
        // Slots
        for (i = [0, 180]) {
            rotate([0,0,i])
                translate([-slot_w/2, -cyl_d/2, 0])
                    cube([slot_w, cyl_d, slot_d]);
        }
    }
}

// 3. Flanged Hollow Cylinder
module flanged_hollow_cylinder() {
    difference() {
        union() {
            cylinder(h=cyl_h, d=cyl_d);
            translate([0,0,cyl_h])
                cylinder(h=flange_h, d=flange_d);
        }
        // Hollow bore
        translate([0,0,-1])
            cylinder(h=cyl_h+flange_h+2, d=bore_d);
    }
}

// 4. Solid Flanged Cylinder
module solid_flanged_cylinder() {
    difference() {
        union() {
            cylinder(h=cyl_h, d=cyl_d);
            translate([0,0,cyl_h])
                cylinder(h=flange_h, d=flange_d);
        }
        // Conical hole
        translate([0,0,0])
            cylinder(h=cone_h, d1=cone_d1, d2=cone_d2);
    }
}

// 5. Slotted Inner Hub
module slotted_inner_hub() {
    difference() {
        union() {
            cylinder(h=cyl_h, d=cyl_d);
            translate([0,0,cyl_h])
                cylinder(h=flange_h, d=flange_d);
        }
        // Recess
        translate([0,0,0])
            cylinder(h=recess_h, d=recess_d);
        // Internal arms (slots)
        for (i = [0, 180]) {
            rotate([0,0,i])
                translate([-slot_w/2, -recess_d/2, 0])
                    cube([slot_w, recess_d, recess_h]);
        }
        // Center hole
        translate([0,0,0])
            cylinder(h=cyl_h+flange_h, d=center_hole_d);
    }
}

// Render all components for preview
translate([-40,0,0]) slotted_end_cap();
translate([0,0,0]) slotted_cylinder_with_flange();
translate([40,0,0]) flanged_hollow_cylinder();
translate([-40,-30,0]) solid_flanged_cylinder();
translate([0,-30,0]) slotted_inner_hub();