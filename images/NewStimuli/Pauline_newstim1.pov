  #include "colors.inc"
  
  background{Black}
  
  camera {
    angle 15
    location <0,0,-80>
    look_at <0,0,0>
  }
  
  light_source { <-5, 5, -10> color White }
  light_source { <5, -5, -10> color White }
  light_source { <-5, -5, -10> color White}
  light_source { <5, 5, -10> color White}
  

#declare NewStimBlob1 = blob{
	threshold 0.05
	
	sphere { 
	<2,2,0>, 3.5, 1
		}
	sphere {
	<-2,2,0>, 3.5, 1
		}
	sphere {
	<-2,-2,0>, 3.5, 1
		}
	sphere{
	<2,-2,0>, 3.5, 1
		}
	sphere{
	<0,0,0> 2, 1
	scale <1,1.5,4>
		}
	}

object{ NewStimBlob1
	pigment {White}
	rotate<0,0,0>
	}