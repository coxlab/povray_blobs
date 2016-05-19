#include "colors.inc"
#include "finish.inc"
#include "textures.inc"

background { Pink }

camera {
    location <cam_pos_x,cam_pos_y,cam_pos_z>
    look_at <cam_look_x,cam_look_y,cam_look_z>
    }
    
light_source {

#declare sclera = sphere {
    pigment {
        }
     finish {
   refraction 1
   roughness .01
      }
   }
   
#declare iris = sphere {
    pigment {
        }
     finish {
   refraction 0
      }
   }


#declare pupil = cylinder {
   pigment{
   color rgbf <0,0,0,0>
   }
}

#declare realeye = difference {


object{ sclera }
object{ realeye }
