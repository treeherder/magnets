cl = 45; // camera length
cw = 25; // camera width
wd = 8;  // word depth
ca = 5;  // crack angle

inf = cl * 4;   // "infinity"
zer = 0.001; // "zero"

module ground() {
	difference() {
		minkowski() {
			translate([0,0,(zer-inf)])
				cylinder(inf,zer,zer,$fn=3);
			child();
		}
		translate([-inf/2,-inf/2,-2*inf])
			cube([inf,inf,2*inf]);
	}
}

module shard(a = 0,s = 1) {
	translate([45,12,cw/2])
		rotate([a,0,0])
		scale([1,s*5,1])
		rotate([0,0,60])
		cylinder(cw*3,cw,cw,$fn=3,center=true);
}
module shards() {
	shard(0,1);
	shard(90,1.3);
	shard(30,0.8);
	shard(110,0.3);
	shard(-40,0.1);
}
module crack() {
	translate([0,0,-2])
		rotate(a=-ca,v=[0,1,0])
		difference() {
			child();
			shards();
		}
	intersection() {
		child();
		shards();
	}
}

module lens() {
	difference() {
		cylinder(7.5,10,10);
		cylinder(8.5,9,9);
	}
	scale([1,1,0.75])
		rotate([-45,45,0])
		sphere(r=10,$fn=40);
}

module corner_tilt(x,y) {
	rotate(a=atan(x/sqrt(pow(x,2)+pow(y,2))),v=[x,y,0])
		child();
}

difference() {
	translate([-25,-7,0]) union() {

		// camera
		ground()
			scale([1,1,0.24])
			corner_tilt(x=cl,y=cw)
			crack() union() {
				cube([cl,cw,cw]);
				translate([3,cw/2,cw/2])
					rotate([0,-90,0])
					lens();
			}

		intersection() {
			translate([25,7,0]) scale([1,1,0.1663]) sphere(r=50,$fn=100);
			union() {

		// fuck
		translate([-8,-23])
			linear_extrude(wd)
			scale([0.885,1.5])
			import("fuck.dxf");

		// surveillance
		translate([12,-11])
			linear_extrude(wd)
			scale([0.32,1])
			import("surveillance.dxf");

			}
		}
	}

	// magnet holes
	translate([0,0,0.3])  cylinder(1.75,6.5,6.5);
	translate([0,0,-0.1]) cylinder(1.75,0.5,0.5);
}
