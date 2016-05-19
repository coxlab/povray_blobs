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
	<0,0,0>, 4, 1
	scale<1,5,3>
	translate<0,0,0.5>
	rotate<0,0,30>
	}
	sphere{
	<0,0,0>, 4, 1
	scale<1,5,3>
	translate<0,0,0.5>
	rotate<0,0,70>
	}
	sphere{
	<0,0,0>, 8, 1
	scale<0,1.5,0>
	translate<1,12,0>
	rotate<0,0,-37>
	}
	}
object{ NewStimBlob7
	pigment {White}
	translate<-10,-8,0>
	rotate<0,0,40>
	rotate<0,60,0>
	finish{
	phong 0.0
	}
	}