wall_thickness=6.5;
base_thickness=2.0;
bb_depth=20;
bb_width=55.5;
bb_height=88.5;
bb_curve_corner=10;

bb_lid_thickness=2;
bb_lid_depth=2.5;
bb_lid_shrink=0.05;

corner_size=12;

// Battery holder
bat_width=32;
bat_height=64;
bat_depth=8;
bat_wall=5.0;
bat_ceil=2.0;

module RoundedBB(extra_width,extra_height,depth,curve=bb_curve_corner) {
	minkowski() {
		cube([bb_width-curve+extra_width,bb_height-curve+extra_height,depth],center=true);
		cylinder(r=curve/2, h=0.0001, $fn=32, center=true);
	}
}

module BeagleLid(curve=bb_curve_corner) {
	difference() {
		union() {
			RoundedBB(wall_thickness, wall_thickness, bb_lid_thickness, curve);
			translate([0,0,bb_lid_thickness/2+bb_lid_depth/2]) {
				difference() {
					RoundedBB(-bb_lid_shrink, -bb_lid_shrink, bb_lid_depth, curve-2);
					*RoundedBB(-bb_lid_shrink-5, -bb_lid_shrink-5, bb_lid_depth, curve-2);
					cube([bb_width-corner_size,bb_height,bb_lid_depth*5],center=true);
					cube([bb_width,bb_height-corner_size,bb_lid_depth*5],center=true);
				}
			}
/*
			translate([0,-(bb_height-bat_height)/2+2,bb_lid_thickness/2+bat_depth/2+bat_ceil/2]) {
				cube([bat_width+bat_wall,bat_height+bat_wall,bat_depth+bat_ceil], center=true);
			}
*/
		}
/*
		// Carve out the space in the battery holder
		translate([0,-(bb_height-bat_height)/2+2,0]) {
			cube([bat_width,bat_height,bb_lid_thickness+bat_depth*2], center=true);
		}

		// Take slices out of the battery holder
		translate([0,-(bb_height-bat_height)/2+2,bb_lid_thickness/2+bat_depth/2+bat_ceil/2]) {
			cube([bat_width+bat_wall,20,bat_depth+bat_ceil], center=true);

			translate([0,-25,0])
				cube([bat_width+bat_wall,20,bat_depth+bat_ceil], center=true);

			translate([0,25,0])
				cube([bat_width+bat_wall,20,bat_depth+bat_ceil], center=true);
		}
*/
	}
}

BeagleLid();
