  #include "colors.inc"
  
  background{Black}
  
  camera {
	angle 50
    location <0,0,-80>
    look_at <0,0,0>
  }
  
  light_source { <0,-10,-80> color White}
 

#declare NewStimBlob9 = blob{
	threshold 0.1
	
	sphere{
	<0,0,0>, 4, 1
	scale<1,5,1>
	translate<0,0,0.5>
	rotate<0,0,30>
	}
	sphere{
	<0,0,0>, 4, 1
	scale<1,5,1>
	translate<0,0,0.5>
	rotate<0,0,70>
	}
	sphere{
	<0,0,0>, 8, 1
	scale<0,1.5,0>
	translate<1,8,0>
	rotate<0,0,-35>
	}
	sphere{
	<0,0,0>, 6, 1
	scale<0.5,2.5,2.5>
	translate<-9,-7.5,5>
	rotate<0,0,6>
	}
	sphere{
	<0,0,0>, 6, 1
	scale<0.5,2.5,2.5>
	translate<9,-7.5,5>
	rotate<0,0,-80>
	}
	}
object{ NewStimBlob9
	pigment {White}
	rotate<0,0,40>
	rotate<0,60,0>
	finish{
	phong 0.0
	}
	}