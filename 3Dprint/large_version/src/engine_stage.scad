use <library.scad>
include <global_parameters.scad>

inner_radius = 32 / 2;
height = stage_height;
motor_top = 173;
motor_bottom = 10;
fin_num = 9;

// classic fins
fin_r = radius + 50;
fin_h = 25;
fin_angle = 16;


module motor_holder(wall) {
	translate([0, 0, -wall * 3])
	cylinder(r = radius - wall - clear, h = wall * 3);    
}


module inner_ring(angle = 11, segments) {
    rotate([0, 0, angle])
    //translate([0, 0, -wall * 3])
    difference () {
        cylinder(r = inner_radius + wall*3, h = wall*2);
        cylinder(r = inner_radius + wall, h = wall*2);
    }
}


module fins(outer_r, inner_r, wall, height, count, angle) {
    for (i = [1 : count]) {
        rotate([0, 0, i * 360/count])
        translate([-wall / 2, inner_r, 0])
        difference () {
            cube([wall, outer_r - inner_r, height]);
          
            color("red")
            translate([-1, 0, height])
            rotate([-angle, 0, 0])
            cube([wall + 2, (outer_r - inner_r) + height, height]);
        }
    }
    inner_points = [ for (i = [0 : count - 1]) [sin(i * 360/count) * (outer_r) , cos(i * 360/count) * (outer_r)]];
    // calculate coordinates of external fins polygon
    vertex_angle = (180*(count-2)) / count;   // angle in external fins polygon corner.
    outer_points = [ for (i = [0 : count - 1]) [sin(i * 360/count) * (outer_r + wall/sin(vertex_angle/2)) , cos(i * 360/count) * (outer_r + wall/sin(vertex_angle/2))]];
    polygon_paths = [ [ for (i = [0 : count-1]) i ], [ for (i = [count : 2*count-1]) i ]];

    echo("outer points = ", outer_points);
    echo("inner points = ", inner_points);
    echo("paths = ", polygon_paths);
    echo("vertex_angle = ", vertex_angle);
    
    linear_extrude(height = height - (tan(angle)*(outer_r - inner_r)))
        polygon(
            points =  concat(outer_points, inner_points),
            paths = polygon_paths
        );
}


module hull(radius, inner_radius, height, wall, motor_bottom, connection_lenght) {
	difference () {                 // hull shell
		cylinder(r = radius, h = height - connection_lenght);
		cylinder(r = radius - wall, h = height - connection_lenght);
	}

/*
	difference () {
		union () {
			twisted_ribs(
				radius - (wall / 2),
				inner_radius,
				height,
				90,
				rib_count,
				rib_wall
			);						
		}
		
                cylinder(               // bevel inner ring for motor exhaust. 
			r1 = radius - wall,
			r2 = inner_radius,
			h = motor_bottom
		);
                
// connection to the next rocket stage
                translate([0, 0, height - connection_lenght])   // remove ribs to place stage connection section
                difference () {                
                        cylinder(r = radius, h = connection_lenght , $fn=resolution);
                        cylinder(r = radius- 1.5*wall, h = connection_lenght, $fn=resolution);
                }
        }*/

        translate([0, 0, height - connection_lenght])
        difference () {                 // hull shell
                cylinder(r = radius - wall - clear, h = connection_lenght);
                cylinder(r = radius - 2*wall - clear, h = connection_lenght);
        }

        translate([0, 0, height - connection_lenght - 3*wall])        // bevel between connection and hull
        difference () {                
            cylinder(r=radius, h=3*wall);
            cylinder(r1=radius - wall, r2=radius - 2*wall - clear, h=3*wall);
        }        
}

module lock_out(radius, inner_radius, height, wall, clear, connection_lenght){
		translate([-radius+radius/3-wall,0,height-connection_lenght/2])
		sphere(r=radius/3);
		rotate([0,0,-360/3])
		translate([-radius+radius/3-wall,0,height-connection_lenght/2])
		sphere(r=radius/3);
		rotate([0,0,360/3])
		translate([-radius+radius/3-wall,0,height-connection_lenght/2])
		sphere(r=radius/3);
}

module lock_in(radius, inner_radius, height, wall, clear, connection_lenght){
		translate([-radius+radius/3-wall,0,height-connection_lenght/2])
		sphere(r=radius/3-wall);
		rotate([0,0,-360/3])
		translate([-radius+radius/3-wall,0,height-connection_lenght/2])
		sphere(r=radius/3-wall);
		rotate([0,0,360/3])
		translate([-radius+radius/3-wall,0,height-connection_lenght/2])
		sphere(r=radius/3-wall);
		translate([0,0,height-(connection_lenght/2)-(radius/3) ])
		cylinder(r=radius-2*wall-clear, h=(radius/3)*2);
}

module engine_stage () {
    difference () {
	    union () {
		    hull(radius, inner_radius, height, wall, motor_bottom, connection_lenght);
		    //translate([0, 0, motor_top]) motor_holder(wall);
			lock_out(radius, inner_radius, height, wall, clear, connection_lenght);
	    }
		union(){
			lock_in(radius, inner_radius, height, wall, clear, connection_lenght);
			
		}
    }

    fins(fin_r, radius - wall, wall , fin_h, fin_num, fin_angle);
}

engine_stage();
