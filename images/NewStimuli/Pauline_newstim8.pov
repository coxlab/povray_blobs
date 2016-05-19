  #include "colors.inc"
  
  background{Black}
  
  camera {
	angle 50
    location <0,0,-80>
    look_at <0,0,0>
  }
  
  light_source { <0,-10,-80> color White}
 

#declare NewStimBlob8 = blob{
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
	translate<5,5,0>
	}
	sphere{
	<0,0,0>, 6, 1
	scale<1.2,2.5,2.5>
	translate<-9,-7.5,6>
	rotate<0,0,6>
	}
	sphere{
	<0,0,0>, 6, 1
	scale<1.2,2.5,2.5>
	translate<9,-7.5,6>
	rotate<0,0,-80>
	}
	}
object{ NewStimBlob8
	pigment {White}
	rotate<0,0,40>
	rotate<0,60,0>
	finish{
	phong 0.0
	}
	}