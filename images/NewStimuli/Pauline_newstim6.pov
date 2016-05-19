  #include "colors.inc"
  
  background{Black}
  
  camera {
	angle 50
    location <0,0,-80>
    look_at <0,0,0>
  }
  
  light_source { <0,-10,-80> color White}
 

#declare NewStimBlob1 = blob{
	threshold 0.1
	
	sphere{
	<0,0,0>, 4, 1
	scale<1.5,7,1>
	translate<0,0,0.5>
	rotate<-20,0,40>
	}
	sphere{
	<0,0,0>, 4, 1
	scale<1.5,7,1>
	translate<0,0,0.5>
	rotate<20,0,40>
	}
	sphere{
	<0,0,0>, 8, 1
	translate<8,5,0>
	}
	sphere{
	<0,0,0>, 12, 1
	scale<0,0,1.4>
	translate<-8,-7.5,5>
	}
	}
object{ NewStimBlob1
	pigment {White}
	rotate<0,0,50>
	rotate<0,0,0>
	}