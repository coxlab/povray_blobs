  #include "colors.inc"    background{White}    camera {    angle 15    location <0,10,-10>    look_at <0,0,0>  }    light_source { <10, 20, -10> color White }    #declare bl1 = blob {    threshold .65    sphere { <0,0,0>, .8, 1      	translate <-0.2, 0, 0>    	scale<3, 1, 1>    	rotate <0,0,0>    }    sphere { <0,0,0>, .8, 1      	translate <0.7, 0, 0>    	scale<1, 1, 1>    	rotate <0,0,0>        }    sphere { <0,0,0>, .8, 1      	translate <0, 0, -0.7>    	scale<1, 1, 1>    	rotate <0,0,0>      }    finish { phong 1 }  }  	  object{ bl1 pigment {Red} }