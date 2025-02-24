eps=1/128;
$fn = 100;                          // how polligonall you want the model 

module toroidal_propeller(
    blades = 4,                     // number of blades
    height = 8,                     // height
    blade_length = 68,              // blade length in mm
    blade_width = 58,               // blade width in mm
    blade_thickness = 2,            // blade thickness in mm
    blade_hole_offset = 0.4,        // blade hole offset
    blade_attack_angle = 30,        // blade attack angle
    blade_offset = -6,              // blade distance from propeller axis
    safe_blades_direction = "PREV", // indicates if a blade must delete itself from getting into the previous (PREV) or the next blade (NEXT).
    
    hub_d = 16,                     // hub diameter
    hub_screw_d = 5.5,              // hub screw diameter
    hub_notch_height = 0,           // height for the notch 
    hub_notch_diameter = 0,          // diameter for the notch
    thole = 13.1, // diameter of central twisted hole
){
    difference(){
        union(){
            // Hub
            cylinder(h=height,d=hub_d);
            // Propellers
            for(a=[0:blades-1]){
                rotate([0,0,a*(360/blades)]){
                    difference(){
                        translate([blade_offset,0,0])
                            blade(
                                height = height,
                                length = blade_length,
                                width = blade_width,
                                thickness = blade_thickness,
                                offset = blade_hole_offset,
                                attack_angle = blade_attack_angle
                            );
                        
                        // Substract what is inside other blades

                        l = height / tan(blade_attack_angle);
                        p = 2 * PI * blade_length / 2;

                        twist = l/p  * 360;

                        cw_ccw_mult = (twist > 0 ? -1 : 1) * (safe_blades_direction == "PREV" ? 1 : -1);
                        rotate([0,0, cw_ccw_mult * 360/blades])
                            translate([blade_offset,0,-eps/2])
                                linear_extrude(height=height+eps, twist=twist)
                                    translate([blade_length/2,0,0])
                                        scale([1, (blade_width-16*eps)/(blade_length-16*eps)]) circle(d=blade_length-16*eps);
                    }
                }
            }
        }
        TwistHole(thole/2,height);
       /* 
        // Hub hole
        translate([0,0,-eps/2])
            cylinder(h=height+eps, d=hub_screw_d);

        // Empty hub
        translate([0,0,-eps/2])
            cylinder(h=hub_notch_height+eps, d=hub_notch_diameter);
        */
    }
}

module TwistHole(radi=5,high=10 ){
    //$fn=20;
    translate([0,0,-eps/2])
    //linear_extrude(height=high+ eps,twist=-135,slices=30) { // set twist positive 4 clockwise
    linear_extrude(height=high + eps,twist=-13.5 * (high + eps),slices=((high+ eps) * 5)) {
        offset(r=2){
            square(radi, center = true);
        }
    }
}

module blade(height, length, width, thickness, offset, attack_angle){

    l = height / tan(attack_angle);
    p = 2 * PI * length/2;

    linear_extrude(height=height, twist=l/p  * 360, convexity=2)
        difference(){
            translate([length/2,0,0])
                scale([1, width/length]) circle(d=length);
    
            translate([length/2 + offset,0,0])
                scale([1, (width-thickness)/(length-thickness)]) circle(d=length-thickness);
    }
}
toroidal_propeller();
