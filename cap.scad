// This is a screw-on collar to attach two UK milk jugs neck-to-neck.
// See http://pozorvlak.livejournal.com/150072.html for why you might want to
// do this.
// Designed by Miles Gould, February 2013

// Measurements, in millimetres.
height = 22;   // Height of the collar.
               // Should be a bit more than the height of two caps.
inner_r = 19;  // inner radius of the cylinder
outer_r = 21;  // outer radius of the cylinder
pitch = 4.1;   // distance between the crest of one thread and the next.

// Outer collar
difference() {
	cylinder(h=height, r=outer_r);
	cylinder(h=height, r=inner_r);
}

// Helix based on code by Andrew Plumb, 2010
// See http://rocklinux.net/pipermail/openscad/2010-January/000098.html

module helix_footprint(helix_r=50
	,arm_r=10
	) {
	translate([ -helix_r,0])
      circle(arm_r,0);
}

module helix_coil(helix_r=50
	, arm_r=10
	, helix_h=100
	, helix_twist=360.0
	) {
  linear_extrude(height=helix_h, convexity=10, twist=helix_twist)
	helix_footprint(helix_r=helix_r
		,arm_r=arm_r
	);
}

helix_coil(helix_h=height
	,arm_r=2
	,helix_r=inner_r
	,helix_twist=-(height / pitch * 360)
	);
