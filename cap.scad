// This is a replacement bottle top for Dave's Insanity Sauce.
// I'd have expected a company producing such an algogenic product to use more
// reliable bottle-sealants, but apparently not...
// Designed by Miles Gould, February 2013

// Measurements, in millimetres.
height = 16;   // outer height of the cap
wall_thickness = 2; // thickness of the cap sides and top
inner_r = 11.5;  // inner radius of the cylinder
outer_r = inner_r + wall_thickness;  // outer radius of the cylinder
pitch = 3;   // distance between the crest of one thread and the next.
thread_r = 2; // radius of the thread

module outer_wall() {
        cylinder(h=height, r=outer_r);
}

// Outer collar
difference() {
	outer_wall();
	translate([0, 0, wall_thickness])
		cylinder(h=height-wall_thickness, r=inner_r);
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
                ,arm_r=thread_r
                ,helix_r=inner_r
                ,helix_twist=-(height / pitch * 360)
                );
}

intersection() {
        thread();
        outer_wall();
}
