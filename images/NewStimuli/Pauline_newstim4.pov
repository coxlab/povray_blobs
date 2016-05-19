  #include "colors.inc"
  
  background{Black}
  
  camera {
	angle 50
    location <0,0,-80>
    look_at <0,0,0>
  }
  
  light_source { <0,-10,-80> color White}
 

#declare NewStimBlob4 = blob{
	threshold 0.1
	
	sphere{
	<0,0,0>, 4, 1
	scale<1,6,1>
	translate<0,0,0.5>
	rotate<0,0,20>
	}
	sphere{
	<0,0,0>, 4, 1
	scale<1,6,1>
	translate<0,0,0.5>
	rotate<0,0,60>
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
object{ NewStimBlob4
	pigment {White}
	rotate<0,0,50>
	rotate<0,60,0>
	finish{
	phong 0.0
	}
	}