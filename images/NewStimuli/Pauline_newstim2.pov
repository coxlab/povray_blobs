  #include "colors.inc"
  
  background{Black}
  
  camera {
	angle 60
    location <0,10,-100>
    look_at <0,5,0>
  }
  
  light_source { <0, -20, -60> color White}
   

#declare NewStimBlob2 = blob{
	threshold 0.05
	
	sphere{
	<0,3,0>, 5, 1
	scale<5,4,0>
	rotate<-15,0,0>
	}
	sphere{
	<0,-2,0>, 3, 1
	scale<4,6,3>
	rotate<35,0,0>
	translate<0,0,1.5>
	}
	sphere{
	<6,0,0>, 2, 1
	scale<3,5,6>
	rotate<-40,0,0>
	translate<0,0,0.8>
	}
	sphere{
	<-6,0,0>, 2, 1
	scale<3,5,6>
	rotate<-40,0,0>
	translate<0,0,0.8>
	}
	}

object{ NewStimBlob2
	pigment {White}
	rotate<0,60,0>
	finish {
  	   phong 0.0
	   diffuse 0.9
	   ambient 0.1
    }
	} 
	