  #include "colors.inc"    background{Black}    camera {    angle 15    //location <0,0,-10> // original poisiton (till Nov 7, 2008)    //location <0,0,-11> // new position (to fit stimuli in the frame with the new x rotations)    location <0,0,-13> // still new position (to fit stimuli with even larger x rotations - 30 deg)    look_at <0,0,0>  }    //light_source { <10, 20, -10> color White }  //light_source { <light_pos_x, light_pos_y, light_pos_z> color White }    light_source {    <light_pos_x, light_pos_y, light_pos_z>    color White    area_light <0, 5, 0>, <0, 0, 5>, 5, 5    adaptive 1.5 //(higher is the number, more accurate is the shadow)    jitter  }      #declare StimBlob2 = blob {    threshold 0.2    //sfera (culo)    sphere { <0,0,0>, .8, 1  //    	translate <0, -0.2, 0.5>    	translate <0, -0.2, 0.7>    	scale<0.8, 1.4, 0.8>//    	rotate <30,0,0>    	rotate <20,0,0>    }    // orecchia sx    sphere { <0,0,0>, .8, 1      	translate <0, 0, -0.5>    	scale<0.6, 0.6, 2>    	rotate <40,0,55>        }    // orecchia dx    sphere { <0,0,0>, .8, 1      	translate <0, 0, -0.5>    	scale<0.6, 0.6, 2>    	rotate <40,0,-55>        }      }    object{ StimBlob2   	rotate <cam_rot_x, cam_rot_y, cam_rot_z>  	translate <obj_pos_x, obj_pos_y, obj_pos_z>  	scale <obj_scale_x obj_scale_y obj_scale_z>  	pigment {White}   	finish {  	   phong 0.0 //0.0       ambient 0.4 //0.2 //0.4 (original value, till Dec 2, 2008)       diffuse 0.6 //0.2 //0.6 (original value, till Dec 2, 2008)    }  }