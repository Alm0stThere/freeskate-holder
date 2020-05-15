include <constants.scad>
include <util.scad>

module clip() {
    module side() {
        outer = spring_axle_diameter / 2 + clip_thickness;
        difference() {
            union() {
                rotate([0, 90, 0])
                    cylinder(h = clip_wall_width,
                             r = outer);
                translate([0,
                           -spring_axle_diameter / 2,
                           -spring_arm_length])
                    cube([clip_thickness,
                          spring_axle_diameter + clip_thickness,
                          spring_arm_length]);

            }
            rotate([0, 90, 0])
                translate([0, 0, -epsilon])
                    cylinder(h = clip_wall_width + 2 * epsilon,
                             r = bolt_diameter / 2 + 0.2);
        }
    }

    translate([0,
               spring_axle_diameter / 2,
               -spring_arm_length])
        cube([clip_width,
              clip_thickness,
              spring_arm_length]);

    side();
    translate([spring_axle_length + cliphouse_wall_width, 0, 0])
        side();

    hull(){
        translate([0, -20, -16])
            sphere(5);
        translate([clip_width, -20, -16])
            sphere(5);
    }

    difference() {
        union() {
            rotate([-130 + 90, 0, 0])
                translate([0, -9, -25])
                    prism(clip_width, 9, 9);

            translate([clip_width, 0, 0])
                rotate([-90, 0, 90])
                    arc(h = clip_width,
                        r = spring_arm_length + 4,
                        a = 130,
                        w = 9);
        }

        translate([clip_width - clip_wall_width, 0, 0])
            rotate([-90, 0, 90])
                cylinder(h = clip_width - 2 * clip_wall_width,
                    r = spring_arm_length);

        translate([-epsilon,
                   spring_axle_diameter / 2 + clip_thickness,
                   -spring_arm_length * 2])
            cube([clip_width + 2 * epsilon,
                  spring_arm_length,
                  spring_arm_length * 2 + epsilon]);
    }

    // roof
    rotate([90, 0, 90])
        arc(h = clip_width,
            r = spring_axle_diameter / 2 + clip_thickness,
            a = 130,
            w = wall_width);
}

color("gold") clip();
