#!/usr/bin/perl

$inputfile = $ARGV[0];

$lighting_distance = 6000;
#$xres = 120;
#$yres = 120;
$xres = 400;
$yres = 400;
$pi = 3.14169;

$elevation_factor = 5;
#@elevations = (-7..7);
@elevations = (-7, 0, 7);

$azimuth_factor = 1;
#@azimuths = (-7..7);
@azimuths = (-35, 0, 35);

$lighting_factor = 30;
#@lighting_azimuths = (-1 .. 1);
@lighting_azimuths = (-1);

$lighting_elevation_offset = 15;
#@lighting_elevations = (-1 .. 1);
@lighting_elevations = (0);

my $lighting_azimuth, $lighting_elevation, $azimuth, $elevation;

#for($elevation = 0; $elevation <= 20; $elevation += 10){
foreach $elevation_draw (@elevations){
	$elevation = $elevation_draw * $elevation_factor;

	#for($azimuth = 0; $azimuth <= 20; $azimuth += 10){
	foreach $azimuth_draw (@azimuths){
		
		$azimuth = $azimuth_draw * $azimuth_factor;
	
		#for($lighting_elevation = -10; $lighting_elevation <= 10; $lighting_elevation += 20){
		foreach $lighting_elevation_draw (@lighting_elevations){
			$lighting_elevation = $lighting_elevation_draw * $lighting_factor;
			$lighting_elevation += $lighting_elevation_offset;
			$lighting_elevation *= 2*$pi / 360;	
				
			#for($lighting_azimuth = -10; $lighting_azimuth <= 10; $lighting_azimuth += 20){
			foreach $lighting_azimuth_draw (@lighting_azimuths){
				$lighting_azimuth = $lighting_azimuth_draw * $lighting_factor;
				$lighting_azimuth *= 2*$pi / 360;
			
				
			
				# if(abs($azimuth) < 0.00001){
# 					$azimuth = 0;
# 				}
# 				if(abs($elevation) < 0.00001){
# 					$elevation = 0;
# 				}
# 				if(abs($lighting_elevation) < 0.00001){
# 					$lighting_elevation = 0;
# 				}
# 				if(abs($lighting_azimuth) < 0.00001){
# 					$lighting_azimuth = 0;
# 				}

			
				$lighting_z = $lighting_distance * cos($lighting_azimuth);
				$lighting_x = $lighting_distance * sin($lighting_azimuth);
				$lighting_y = $lighting_distance * sin($lighting_elevation);
				
				$commandstring = "povray Display=false +I$inputfile\.pov +W$xres +H$yres ";
				$commandstring .= " Declare=azimuth=$azimuth ";
				$commandstring .= " Declare=elevation=$elevation ";
				$commandstring .= " Declare=lighting_x=$lighting_x ";
				$commandstring .= " Declare=lighting_y=$lighting_y ";
				$commandstring .= " Declare=lighting_z=$lighting_z ";
				$commandstring .= " Declare=the_distance=950 ";
				
				$commandstring .= "Antialias=true Quality=5 ";
				
				print("$commandstring\n");
				system($commandstring);
				
				
				
				$newname = $inputfile . "_az" . sprintf("%.3g", $azimuth)  . 
									    "_el" . sprintf("%.3g", $elevation) . 
										"_la" . sprintf("%.3g", $lighting_azimuth * 180 / $pi) . 
										"_le" . sprintf("%.3g", $lighting_elevation * 180 / $pi);
				
				$copystring = "cp $inputfile\.png $newname\.png";
				#print($copystring);
				system($copystring);
				
			}
		}
	}
}