use <src/toroidal_propeller.scad>
    $fn = 100;                      // how polligonall you want the model

toroidal_propeller(
    blades = 4,                     // number of blades | Default(3)
    height = 8,                     // height | Default(6)
    blade_length = 68,              // blade length | Default(68)
    blade_width = 64,               // blade width | Default(42)
    blade_thickness = 2.4,          // blade thickness | Default(4)
    blade_hole_offset = 0.4,        // blade hole offset | Default(1.4)
    blade_attack_angle = -40,        // blade attack angle | Default(35)
    blade_offset = -6,              // blade distance from propeller axis | Default(-6)
    safe_blades_direction = "NEXT", // indicates if a blade must delete itself from getting into the previous (PREV) or the next blade (NEXT) | Default("PREV")
    hub_d = 20,                     // hub diameter | Default(16)
    hub_screw_d = 5.5,              // hub screw diameter | Default(5.5)
    hub_notch_height = 0,           // height for the notch | Default(0 = [No support])
    hub_notch_diameter = 0,         // diameter for the notch | Default(0 = [No support])
	thole = 13.15                   // twisted hole diameter for mating to launcher
);
