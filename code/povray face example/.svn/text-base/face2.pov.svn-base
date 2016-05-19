//#include "AutoClck.mcr"

//-------------------------------------------------
//POV-Ray Main scene file
//This file has been created by PoseRay v3.0.1.271
//3D model to POV-Ray/Moray Converter.
//Author: FlyerX
//Email: flyer_2000@excite.com
//Web: http://user.txcyber.com/~sgalls/
//----------------------------------------------------
//Files needed to run the POV-Ray scene:
//POV-Ray configuration file:john_hi_obj_pov.ini Open this file in POV-Ray and press run to obtain the render
//POV-Ray Scene file:john_hi_obj.pov
//POV-Ray geometry mesh file:john_hi_obj_pov.inc
//POV-Ray material file:john_hi_obj_pov_mat.inc
//john_hi_obj_eyeL_hi.jpg
//john_hi_obj_eyeR_hi.jpg
//john_hi_obj_skin_hi.jpg
//----------------------------------------------------
//Files used in PoseRay for the creation of this scene:
//3D model file: john_hi_obj.obj
//Material file: john_hi_obj.mtl
//Camera file: 
//Lights file: 
//----------------------------------------------------
//Model Statistics:
//Number of vertices............. 6174
//Number of normals.............. 6174
//Number of UV coordinates....... 6365
//Number of materials............ 3
//Number of unique groups........ 3
//Number of polygons............. 6054
//Number of valid triangles...... 12108
//Number of line segments........ 0
//UV boundaries........ from u,v=(0,-0.00278294)
//                        to u,v=(1,1)
//Bounding Box....... from x,y,z=(-98.9599,-156.291,-148.521)
//                      to x,y,z=(99.2957,128.577,90.7747)
//Bounding Box size.... dx,dy,dz=(198.2556,284.868,239.2957)
//Bounding box diagonal.......... 421.5655
//Bounding box center..... x,y,z=(0.1679001,-13.857,-28.87315)
//Memory allocated for geometry.. 1037792 Bytes
// 
//-------------------------------------------------
//IMPORTANT:
//This file was designed to run with the following command line options: 
// +W631 +H433 +FN +AM1 +A0.3 -UA
//if you are not using an INI file copy and paste the text above to the command line box before rendering
 
//#include "colors.inc"
//#include "skies.inc"
//#include "textures.inc"                                        
#include "face2_POV_mat.inc"
#include "face2_POV_geom.inc" //the geometry is in this file


global_settings {
  //This setting is for alpha transparency to work properly.
  //Increase by a small amount if transparent areas appear dark.
   max_trace_level 10
   //ambient_light rgb<1,1,1>*2
   
   
   radiosity {
         pretrace_start 0.08
         pretrace_end   0.04
         count 35
   
         nearest_count 15
         error_bound 1.8
         recursion_limit 3
   
         low_error_factor 0.5
         gray_threshold 0.0
         minimum_reuse 0.015
         brightness 1
   
         adc_bailout 0.01/2
    }
   
}
 
//CAMERA PoseRayCAMERA
camera {
        perspective
        
		up <0, 1>
		//up <0,1,0>
        right <-1,0,0>
        //right <-1.457275,0,0>
        //location <0, 0 ,1250>
		location <0, 0, the_distance>
        look_at <0, 0, 0>
        //look_at <0, 0,1263.696>
        angle 24.17847 // horizontal FOV angle
        //rotate <0,0,-1.951951> //roll
        //rotate <-17.98858,0,0> //pitch
        //rotate <0,-11.91257,0> //yaw
        //translate <0.1679001,-13.857,-28.87315>
        }
 
//PoseRay default Light attached to the camera
light_source {
              <lighting_x,lighting_y,lighting_z> //light position
              color rgb <1,1,1>*1.5
              parallel
              point_at <0,0,0>
              //rotate <0,0,-1.951951> //roll
              //rotate <-17.98858,0,0> //elevation
              //rotate <0,-11.91257,0> //rotation
             }
 
//A Colored Background
background { color rgb<1,0,1>  }
   
#declare tipangle = -0; 
                       
                        
//Assembled object that is contained in C:\Documents and Settings\David.METIS\Desktop\FaceGenFaces\john_hi_obj_pov.inc
object{
      face2_ 
                       
      rotate <20+elevation, azimuth, 0>
	
 }
