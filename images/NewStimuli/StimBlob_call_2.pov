  #include "colors.inc"    background{Black}    camera {    angle 15    location <0,0,-20>    look_at <0,0,0>  }    //light_source { <10, 20, -10> color White }  light_source { <0, -10, -10> color White }    #declare StimBlob2 = blob {    threshold 0.2    //sfera (culo)    sphere { <0,0,0>, .8, 1  //    	translate <0, -0.2, 0.5>    	translate <0, -0.2, 0.7>    	scale<0.8, 1.4, 0.8>//    	rotate <30,0,0>    	rotate <20,0,0>    }    // orecchia sx    sphere { <0,0,0>, .8, 1      	translate <0, 0, -0.5>    	scale<0.6, 0.6, 2>    	rotate <40,0,55>        }    // orecchia dx    sphere { <0,0,0>, .8, 1      	translate <0, 0, -0.5>    	scale<0.6, 0.6, 2>    	rotate <40,0,-55>        }      }    object{ StimBlob2   	rotate <0,0,0>  	translate <0,0,0>  	scale <0,0,0>  	pigment {White}   	finish {  	   phong 0.0       ambient 0.4 //0.3       diffuse 0.6    }  }