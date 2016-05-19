  #include "colors.inc"
  
  background{Black}
  
  camera {
	angle 25
    location <0,0,-80>
    look_at <0,0,0>
  }
  
  light_source { <0,-10,-80> color White}


#declare NewStimBlob5 = blob{
	threshold 0.7
	
	sphere{
	<0,0,0>, 4, 1
	scale<1,6,1>
	translate<0,0,0.5>
	rotate<30,0,20>
	}
	sphere{
	<0,0,0>, 4, 1
	scale<1,6,1>
	translate<0,0,0.5>
	rotate<-30,0,60>
	}
	sphere{
	<0,0,0>, 4, 1
	scale<1,6,1>
	translate<0,0,0.5>
	rotate<30,0,100>
	}
	sphere{
	<0,0,0>, 4, 1
	scale<1,6,1>
	translate<0,0,0.5>
	rotate<-30,0,140>
	}
	}
object{ NewStimBlob5
	pigment {White}
	rotate<0,0,8>
	rotate<0,60,0>
	finish{
	phong 0.0
	diffuse 0.7
	}
	}
	