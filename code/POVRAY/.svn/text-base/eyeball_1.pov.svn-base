#include "colors.inc"
#include "finish.inc"
#include "textures.inc"

background { Pink }

camera {
    location <cam_pos_x,cam_pos_y,cam_pos_z>
    look_at <cam_look_x,cam_look_y,cam_look_z>
    }
    
light_source {   <light_pos_x,light_pos_y,light_pos_z> color White   spotlight   point_at <light_look_x,light_look_y,light_look_z>   radius 5    }

#declare sclera = sphere {    <0, 0, 0>, sclera_rad
    pigment {    color rgbf <1, 1, 1, .8>
        }
     finish {
   refraction 1
   roughness .01   specular 1
      }
   }
   
#declare iris = sphere {    <0, 0, 0>, iris_rad
    pigment {    color rgbf <iris_color_R, iris_color_G, iris_color_B, .2>
        }
     finish {
   refraction 0
      }
   }


#declare pupil = cylinder {   <0, 0, 0>, <0, 0, 2.5>, pupil_rad
   pigment{
   color rgbf <0,0,0,0>
   }
}

#declare realeye = difference {    object { innereyeball }    object { pupil }}


object{ sclera }
object{ realeye }

