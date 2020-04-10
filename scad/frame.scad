include <constants.scad>
use <util.scad>

module corner() {
    arc(h = wall_height,
        w = wall_width,
        r = corner_radius,
        a = 90);

    translate([corner_radius * 0.7, corner_radius * 0.7, 15])
        rotate([0, 90, 315])
            arc(h = wall_width * 2,
                w = wall_width,
                r = 8,
                a = 180);
}

module bridge() {
    bridge_height = 13;
    bridge_size = 25;
    bridge_offset = skate_length - skate_overlap - wall_width;

    // side
    difference(){
        union() {
            translate([skate_width / 2 + gap_around_skate
                        + wall_width - corner_radius,
                       bridge_offset + corner_radius,
                       wall_height - 6])
                arc(h = bridge_height + 6,
                    w = wall_width,
                    r = corner_radius,
                    start = 270,
                    a = 0);
            translate([skate_width / 2 + gap_around_skate,
                       bridge_offset + corner_radius + 90,
                       wall_height])
                mirror([0, 1, 0])
                    cube([wall_width, 90, bridge_height]);
        }

        translate([-epsilon,
                   bridge_offset + bridge_size,
                   wall_height + bridge_height + epsilon])
            mirror([0, 0, 1])
                prism(100,
                      110 + epsilon,
                      bridge_height + epsilon * 2);
    }

    // roof
    translate([0,
               bridge_offset + wall_width - epsilon,
               wall_height + bridge_height - wall_width])
        cube([skate_width / 2 + gap_around_skate + wall_width - corner_radius,
              bridge_size - wall_width + epsilon,
              wall_width]);


    difference() {
        translate([skate_width / 2 + gap_around_skate + wall_width - corner_radius,
                   bridge_offset + corner_radius,
                   wall_height - wall_width + bridge_height])
            slice(h = wall_width,
                  r = corner_radius,
                  start = 270,
                  a = 0);

        translate([0,
                   bridge_offset + bridge_size - epsilon,
                   wall_height + bridge_height - wall_width - 10])
            cube([100, 30, 30]);
    }

    // back plate
    translate([-epsilon,
               bridge_offset,
               wall_height - 6])
        cube([skate_width / 2 + gap_around_skate + wall_width + epsilon - corner_radius,
              wall_width,
              bridge_height + 6]);
}

module side_wall() {
    translate([skate_width / 2 + gap_around_skate,
               corner_radius-epsilon,
               0])
        cube([wall_width,
              skate_length * 2 - skate_overlap
               - (corner_radius - wall_width) * 2 + 2 * epsilon + 2,
              wall_height]);

    bridge();

    // upper platform:
    translate([-clip_width / 2 - gap,
               epsilon + wall_width + skate_length * 2 - skate_overlap + 2,
               0])
        rotate([7.4, 0, 180])
            cube([20, 181, wall_width]);

    // support for upper platform:
    translate([-epsilon, 247, 0])
        cube([skate_width / 2 + gap_around_skate + epsilon * 2,
              wall_width,
              12]);

    // lower platform:
    translate([-epsilon, 80, 0])
        cube([skate_width / 2 + gap_around_skate + epsilon * 2,
              10,
              wall_width]);
    translate([clip_width / 2 + gap, 0, 0])
        cube([20, 181, wall_width]);

    // backstop:
    translate([-epsilon,
               skate_length + gap_around_skate * 2 + wall_width,
               0])
        cube([skate_width / 2 + gap_around_skate + wall_width - corner_radius + epsilon * 2,
              wall_width,
              20]);

    translate([skate_width / 2 + gap_around_skate + wall_width - corner_radius,
               skate_length + gap_around_skate * 2 + 2 * wall_width - corner_radius,
               0])
        arc(h = 20,
            w = wall_width,
            r = corner_radius,
            start = 0,
            a = 90);
}

module cliphouse() {
    // back wall
    translate([-cliphouse_wall_width,
               -cliphouse_wall_width - spring_axle_diameter / 2,
               -18])
        cube([clip_width + 2 * cliphouse_wall_width,
              cliphouse_wall_width,
              13 - 2 * gap]);

    module side_wall() {
        difference() {
            union() {
                translate([0, 0, -25])
                    cube([cliphouse_side_wall_width - gap,
                          spring_axle_diameter + 2 * cliphouse_wall_width,
                          25]);

                translate([0, cliphouse_wall_width+spring_axle_diameter/2, 0])
                    rotate([0, 90, 0])
                        cylinder(h = cliphouse_side_wall_width - gap,
                                 r = spring_axle_diameter / 2 + cliphouse_wall_width);

                translate([0, 0, -25])
                    mirror([0, 0, 1])
                        prism(cliphouse_side_wall_width - gap,
                              spring_axle_diameter + wall_width,
                              wall_width + deck_thickness + wall_width +
                               spring_arm_length - 25);
            }

            translate([-epsilon,
                       cliphouse_wall_width + spring_axle_diameter / 2,
                       0])
                rotate([0,90,0])
                    cylinder(h = cliphouse_side_wall_width + 2 * epsilon,
                             r = bolt_diameter / 2);
        }
    }

    difference() {
        translate([-cliphouse_side_wall_width,
                   -cliphouse_wall_width - spring_axle_diameter / 2, 0])
            side_wall();

        translate([-cliphouse_side_wall_width - epsilon, 0, 0])
            rotate([0, 90, 0])
                cylinder(h = 2 + epsilon,
                         r = 5.5 / 2 + 0.5);
    }

    difference() {
        translate([clip_width + gap,
                   -cliphouse_wall_width - spring_axle_diameter / 2, 0])
            side_wall();

        translate([clip_width + cliphouse_side_wall_width - 4, 0, 0])
            rotate([0, 90, 0])
                cylinder(h = 4 + epsilon,
                         r = 5.5 / 2 * (2 / sqrt(3)) + 0.5,
                         $fn = 6);
    }
}

module fullcorner() {
    translate([corner_radius - skate_width / 2 - gap_around_skate - wall_width,
               corner_radius,
               0])
        rotate([0, 0, 180]) // todo: consider mirror instead
            corner();

    translate([-skate_width / 2 - gap_around_skate + corner_radius - wall_width, 0, 0])
        cube([skate_width / 2 + gap_around_skate - corner_radius - clip_width / 2 + wall_width - gap,
              wall_width,
              wall_height]);
}

module one_end() {
    fullcorner();
    mirror([1, 0, 0]) fullcorner();

    translate([-clip_width / 2,
               -spring_axle_diameter/2,
               wall_width + deck_thickness + wall_width + spring_arm_length])
        cliphouse();
}

module frame() {
    side_wall();
    mirror([1, 0, 0]) side_wall();

    one_end();
    translate([0, 2 * skate_length - skate_overlap + 8, 0])
        mirror([0, 1, 0])
            one_end();
}

color("gold") frame();
