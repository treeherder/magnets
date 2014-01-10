difference() {
	scale([0.5,0.5,1])
		rotate(a=[0,180,90])
		translate([-90,-105,0])
		linear_extrude(height = 5)
		import("sudo.dxf");
	translate([0,0,-3]) union() {
		cylinder(2.5,6.5,6.5);
		cylinder(5.0,5.25,5.25);
	}
}