//==================================================
//POV-Ray Main scene file
//==================================================
//This file has been created by PoseRay v3.9.0.398
//3D model to POV-Ray/Moray Converter.
//Author: FlyerX
//Email: flyerx_2000@yahoo.com
//Web: http://mysite.verizon.net/sfg0000/
//==================================================
//Files needed to run the POV-Ray scene:
//NARROW_FACE_POV_main.ini (initialization file - open this to render)
//NARROW_FACE_POV_scene.pov (scene setup of cameras, lights and geometry)
//NARROW_FACE_POV_geom.inc (geometry mesh)
//NARROW_FACE_POV_mat.inc (materials)
//NARROW_FACE_eyeL_hi.jpg
//NARROW_FACE_eyeR_hi.jpg
//NARROW_FACE_skin_hi.jpg
//NARROW_FACE_sock.jpg
//NARROW_FACE_teethLower.jpg
//NARROW_FACE_teethUpper.jpg
//NARROW_FACE_tongue.jpg
// 
//==================================================
//Model Statistics:
//Number of triangular faces..... 12280
//Number of vertices............. 6292
//Number of normals.............. 6999
//Number of UV coordinates....... 6498
//Number of lines................ 0
//Number of materials............ 7
//Number of groups/meshes........ 7
//Number of subdivision faces.... 0
//UV boundaries........ from u,v=(0,-0.00278294)
//                        to u,v=(1.00526,1.00117)
//Bounding Box....... from x,y,z=(-106.443,-156.291,-146.421)
//                      to x,y,z=(106.859,125.899,92.1557)
//                 size dx,dy,dz=(213.302,282.19,238.5767)
//                  center x,y,z=(0.208,-15.196,-27.13265)
//                       diagonal 426.6706
//Surface area................... 198108.8
//             Smallest face area 0.01082176
//              Largest face area 1484.857
//Memory allocated for geometry.. 1 MByte
// 
//==================================================
//IMPORTANT:
//This file was designed to run with the following command line options: 
// +W791 +H652 +FN +AM1 +A -UA
//if you are not using an INI file copy and paste the text above to the command line box before rendering
 
#include "colors.inc"
#include "skies.inc"
#include "stars.inc"
#include "textures.inc"
#include "NARROW_FACE_POV_geom.inc" //Geometry
 
global_settings {
  //This setting is for alpha transparency to work properly.
  //Increase by a small amount if transparent areas appear dark.
   max_trace_level 10
 
}
 
//CAMERA PoseRayCAMERA
camera {
        perspective
        up <0,1,0>
        right -x*image_width/image_height
        location <0, 0, 300>
        look_at <0, 0, 0>
        angle 90 // horizontal FOV angle
        rotate <0,0,0> //roll
        rotate <0,0,0> //pitch
        rotate <-20,0,0> //yaw
        translate <0, 0, 0>
        }
 
//PoseRay default Light attached to the camera
light_source {
              <0,0,400> //light position
              color rgb <1,1,1>*1.6
              parallel
              point_at <0,0,0>
              rotate <0,0,0> //roll
              rotate <-20,0,0> //elevation
              rotate <0,0,0> //rotation
             }
 
//Background
background { color rgb<0,0,0>  }
 
//Assembled object that is contained in NARROW_FACE_POV_geom.inc
object{
      NARROW_FACE_
      }
//==================================================
