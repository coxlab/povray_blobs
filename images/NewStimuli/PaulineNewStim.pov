#include "colors.inc"
#include "textures.inc"
  
background{Black}

camera {
	angle 20	
	location <0,5,-70>
	look_at <0,0,0>
}


light_source { <0,-10,-45> color White }
light_source { <0,10,-45> color White }


torus {
  5.5, 2.5
  pigment { color White }
  rotate <-50,0,0>
  translate <0,2,0>
}

sphere {
<0,0,0> 3
pigment {color White}
scale<1.4,2.8,1>
}

sphere {
<0,-40,3> 7
pigment {color White}
scale<0.6, 0.2, 0.8>
}
