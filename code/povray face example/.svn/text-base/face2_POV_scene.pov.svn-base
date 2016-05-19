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
//face2_POV_main.ini (initialization file - open this to render)
//face2_POV_scene.pov (scene setup of cameras, lights and geometry)
//face2_POV_geom.inc (geometry mesh)
//face2_POV_mat.inc (materials)
//face2_eyeL_hi.jpg
//face2_eyeR_hi.jpg
//face2_skin_hi.jpg
//face2_sock.jpg
//face2_teethLower.jpg
//face2_teethUpper.jpg
//face2_tongue.jpg
// 
//==================================================
//Model Statistics:
//Number of triangular faces..... 12280
//Number of vertices............. 6292
//Number of normals.............. 6840
//Number of UV coordinates....... 6498
//Number of lines................ 0
//Number of materials............ 7
//Number of groups/meshes........ 7
//Number of subdivision faces.... 0
//UV boundaries........ from u,v=(0,-0.00278294)
//                        to u,v=(1.00526,1.00117)
//Bounding Box....... from x,y,z=(-95.2977,-156.291,-150.208)
//                      to x,y,z=(96.4289,120.603,100.993)
//                 size dx,dy,dz=(191.7266,276.894,251.201)
//                  center x,y,z=(0.5656,-17.844,-24.6075)
//                       diagonal 420.1563
//Surface area................... 186547.7
//             Smallest face area 0.01052543
//              Largest face area 1197.649
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
#include "face2_POV_geom.inc" //Geometry
 
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
        location <3.663736E-15,0,840.3126>
        look_at <3.663736E-15,0,839.3126>
        angle 30.10781 // horizontal FOV angle
        rotate <0,0,0> //roll
        rotate <-25,0,0> //pitch
        rotate <0,45,0> //yaw
        translate <0.5656,-17.844,-24.6075>
        }
 
//PoseRay default Light attached to the camera
light_source {
              <3.66373598126302E-15,0,840.3126> //light position
              color rgb <1,1,1>*1.6
              parallel
              point_at <3.663736E-15,0,0>
              rotate <0,0,0> //roll
              rotate <-25,0,0> //elevation
              rotate <0,45,0> //rotation
             }
 
//Background
background { color rgb<0.9254902,0.9137255,0.8470588>  }
 
//Assembled object that is contained in face2_POV_geom.inc
object{
      face2_
      }
//==================================================
