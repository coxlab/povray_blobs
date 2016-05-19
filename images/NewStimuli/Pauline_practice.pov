#include "colors.inc"
#include "textures.inc"camera {  location <-2, 3, -10>  look_at <0, 5, 0>}plane {  y, -2  texture {    pigment { checker color Blue color White }    normal {      ripples 0.5    }  }
}sphere {  <0, 5, 0>, 2  pigment 
 { agate }  finish {    reflection 0.3    phong 1  }
}
sphere {  <-2, 4, 6>, 5.6  texture { Jade }}
sphere {<2,2,0> 1.5  texture {    normal {      bumps 1/2      scale 1/6    }    pigment { color rgb <0,0.4,0.6> }  }}light_source { <10, 10, -10> color White }light_source { <-10, 5, -15> color White }