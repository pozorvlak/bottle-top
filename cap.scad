// This is a replacement bottle top for Dave's Insanity Sauce.
// I'd have expected a company producing such an algogenic product to use more
// reliable bottle-sealants, but apparently not...
// Designed by Miles Gould, February 2013

// Measurements, in millimetres.
height = 16;   // outer height of the cap.
inner_r = 10.5;  // inner radius of the cylinder
outer_r = 12.5;  // outer radius of the cylinder
pitch = 3;   // distance between the crest of one thread and the next.

module outer_wall() {
        cylinder(h=height, r=outer_r);
}

// Outer collar
difference() {
	outer_wall();
	translate([0, 0, 2])
		cylinder(h=height-2, r=inner_r);
}

// Helix based on code by Andrew Plumb, 2010
// See http://rocklinux.net/pipermail/openscad/2010-January/000098.html

module helix_footprint(helix_r=50
	,arm_r=10
	) {
	translate([ -helix_r,0])
      circle(arm_r);
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

module thread() {
        helix_coil(helix_h=height
                ,arm_r=2
                ,helix_r=inner_r
                ,helix_twist=-(height / pitch * 360)
                );
}

intersection() {
        thread();
        outer_wall();
}
