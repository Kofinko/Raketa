a=85; r=14.6;
 difference () {
 cylinder(a,r,r,$fn = 1000);
 translate ([0,0,-1]) cylinder (a-3,r-2.5,r-2.5,$fn = 1000);
 translate ([0,0,45]) cylinder (40,9.5,9.5,$fn = 500);
 }
 difference () {
rotate ([90,0,0]) linear_extrude(height = 1.5)
translate ([13.6,0])polygon( points = [[0,0],[a,0],[0,a],[0,0]] );
 rotate ([90,0,0]) linear_extrude(height = 2)
translate ([43.6,0])polygon( points = [[0,0],[a,0],[0,80],[0,0]] );
     }
     difference () {
 rotate ([90,0,180]) linear_extrude(height = 1.5)
translate ([13.6,0]) polygon( points = [[0,0],[a,0],[0,a],[0,0]] );
  rotate ([90,0,180]) linear_extrude(height = 2)
translate ([43.6,0]) polygon( points = [[0,0],[a,0],[0,80],[0,0]] );
     }   
difference  () {
 rotate ([0,270,180])  linear_extrude(height = 1.5)translate ([0,13.6]) polygon( points = [[0,0],[a,0],[0,a],[0,0]] );
  rotate ([0,270,180]) linear_extrude(height = 2)
translate ([0,43.6]) polygon( points = [[0,0],[a,0],[0,a-30],[0,0]] );  
   } 
   difference  () {
 rotate ([0,270,0])  linear_extrude(height = 1.5)translate ([0,13.6]) polygon( points = [[0,0],[a,0],[0,a],[0,0]] );
  rotate ([0,270,0]) linear_extrude(height = 2)
translate ([0,43.6]) polygon( points = [[0,0],[a,0],[0,a-30],[0,0]] );  
   } 
   difference () {
  translate ([0,0,85]) cylinder (10,12,12,$fn = 500);
translate([0,0,45]) cylinder(70,9.5,9.5,$fn = 500);
    }