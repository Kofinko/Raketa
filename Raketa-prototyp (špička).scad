/* NoseOgive,scad
	Ogive Nosecone
   (c) David B. Snyder, 2014
	permission to use for non-commercial
 	purposes. Please credit me when credit is 
	due.  Prease inform me of improvements, 
	with credit information.
	dbsnyder40 (at) gmail.com
/*********************************/

// BT-50, 24mm
// OD 24.8 mm
// ID 24.1 mm
// - 0.05 dr for inside radius

// $fs = 0.5;
// $fa = 5;

dx1 = 0.05;  // fit radius reduction
ratio = 4.0; // Caliber,  ie Height/Diameter
r1a = (14.6);   // OD/2
e = 400;
r2a = 1.05;  // -dx1: ID/2  fit correction not included
dz2 = 3;  // plug lip height
nof = 10; // number of ogive facets
dx0 = 1.5;  // shell thickness
hcy = 12.5; // Height of plug 

h1 = ratio*2*r1a; // Height of nosecone
dz = (h1*dx0)/r1a; // inside shell is lower by this amount - conical estimate

rp = r2a-dx0;  // Plug insert radius


// Ogive Shape
module body(hb,rb) {

	l0 = sqrt((rb*rb)+(hb*hb));
	theta = 180 -(2*atan(hb/rb));
	r1 = hb/sin(theta);  //Ogive radius
	phi = theta/nof;

	echo("h:", hb,"r:",rb,"l:",l0);
	echo("theta:",theta,"r_ogiv:",r1,"phi:",phi);

	union (){
	for (i=[1:(nof-1)]) {
		assign(
			h1 = (r1*sin(i*phi)),
			h2 = r1*sin((i-1)*phi)-0.05,
			r3 = r1*sin(i*phi)*cos((180-(i*phi))/2)/sin((180-(i*phi))/2),
			r4 = r1*sin((i-1)*phi)*cos((180-((i-1)*phi))/2)/sin((180-((i-1)*phi))/2)
		){
			echo("h[",i,"]:",h1,"a:",i*phi,"dr:", r3);
				translate([0,0,h2]){
					cylinder(h=h1-h2,r1=rb-r4,r2=rb-r3,$fn = e);
				}
			
		}
	}
	// top segment, to ensure a point - not r2<0
	assign(
			h1 = (r1*sin(theta)),
			h2 = r1*sin((nof-1)*phi)-0.05,
			r4 = r1*sin((nof-1)*phi)*cos((180-((nof-1)*phi))/2)/sin((180-((nof-1)*phi))/2)
		){
			echo("h[",noi,"]:",h1,"a:",i*phi,"dr:", r4);
				translate([0,0,h2]){
					cylinder(h=h1-h2,r1=rb-r4,r2=0,$fn = e);
				}
			
		}
}
} // end of Body Module

module shell(dx=dx0) {
	assign( h4 = h1-dz) {
	echo ("Inner shell height: ",h4);
	difference() { 
		body(h1,r1a);
		translate([0,0,-0.2]){
	 		body((h4-dz/2),r1a-dx);
		}
	}}
}

module bulkhead() {
	intersection() {
		body (h1, r1a);
		translate([-dx0/2,-r1a]) {cube([dx0,2*r1a,h1]);}
}}

module outer_cyl() { cylinder(h=hcy,r=r2a,$fn = e);}

module cyl_bh() { 
	intersection() { outer_cyl();
		translate([-dx0/2,-r2a,0]) {
			cube([dx0,2*r2a,hcy]);
	}}
}

/* Modules done - start building */

difference() {
	union() {
		shell();
		bulkhead();
        
		rotate(90) {bulkhead();}
	}
	translate([0,0,-0.5]) {
		cylinder(h= dz2 +1+dx1, r=rp+dx1,$fn = e);
	}
}
    difference (){
        translate ([0,0,-10]) cylinder (10,14.6,14.6,$fn = e);
        translate ([0,0,-10]) cylinder (10,12,12,$fn = e);
    }