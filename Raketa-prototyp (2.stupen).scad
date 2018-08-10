a=60; r=14.6;
difference () {
 cylinder(a,r,r,$fn = 500);
    translate([0,0,0]) cylinder(a,r-2.5,r-2.5,$fn = 600);
  cylinder(11,r-2.5,r-2.5,$fn = 500);
    }
   difference () {
    translate ([16,5,0]) cylinder (10,2.8,2.8,$fn = 500);
    translate ([16,5,-1]) cylinder (12,2,2,$fn = 500);
}
difference () {
translate([0,0,58]) cylinder(12,12.6,12.6,$fn = 500);
translate([0,0,58]) cylinder(12,10,10,$fn = 500);
    }