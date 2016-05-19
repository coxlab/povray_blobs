  #include "colors.inc"
  
  background{Black}
  
  camera {
	angle 50
    location <0,0,-80>
    look_at <0,0,0>
  }
  
  light_source { <0,-10,-80> color White}
 

#declare NewStimBlob7 = blob{
	threshold 0.1
	
	sphere{
	<0,0,0>, 8, 1
	scale<0,1.5,0>
	translate<0,4,0>
	rotate<0,0,-35>
	}
	sphere{
	<0,0,0>, 6, 1
	scale<0,2.5,2.5>
	translate<-9,-7.5,5>
	rotate<0,0,6>
	}
	sphere{
	<0,0,0>, 6, 1
	scale<0,2.5,2.5>
	translate<9,-7.5,5>
	rotate<0,0,-80>
	}
	}
object{ NewStimBlob7
	pigment {White}
	rotate<0,0,40>
	rotate<0,60,0>
	finish{
	phong 0.0
	}
	}