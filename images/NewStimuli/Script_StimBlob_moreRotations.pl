#!/usr/bin/perl -w
#
# This script will write and execute a command line call to POVRAY
# to generate multiple views of the two hand made stimuli StimBlob 1 and 2
# It works by calling the pov scripts StimBlob_call_1.pov and StimBlob_call_2.pov

$POVray_script_BaseName = "StimBlob_call_";   # POVray application that must be called from the command line
$n_stim = 2;
$BaseFolderName = "BlobStim_1_2_v";
#$OutputFolder = "BlobStim_1_2";
#$OutputFolder = "BlobStim_1_2_B";
#$OutputFolder = "BlobStim_1_2_C";
#$OutputFolder = "BlobStim_1_2_C";

# Set of camera rotations
#@CamRot_x = qw(  0   0   0  0 0  0  0  );
#@CamRot_y = qw( -90 -60 -30 0 30 60 90 );
#@CamRot_z = qw(  0   0   0  0 0  0  0  );

# Original rotations chosen for training D1 & D2
#@CamRot_x = qw(  0   0   0   0   0   0  0 0  0  0  0  0  0 );
#@CamRot_y = qw( -90 -75 -60 -45 -30 -15 0 15 30 45 60 75 90 );
#@CamRot_z = qw(  0   0   0   0   0   0  0 0  0  0  0  0  0 );

# New rotations for training D1 & D2 (finer steps)
@CamRot_x = qw(  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0    0       0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0);
@CamRot_y = qw( -90 -85 -80 -75 -70 -65 -60 -55 -50 -45 -40 -35 -30 -25 -20 -15 -10 -5    0       5  10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90);
@CamRot_z = qw(  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0    0       0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0);
$n_CamRot = @CamRot_x; # number of camera rotations

# Rotation limits
$RotStart_y = -60;
$RotEnd_y = 60;
$RotStep_y = 15;
$RotStart_x = -30;
$RotEnd_x = 30;
$RotStep_x = 15;

# Location of the whole object/stimulus (x,y,z)
@StimPos1 = qw( 0 -0.18 5 );
@StimPos2 = qw( 0 0 6 );
# Size of the whole object/stimulus (x,y,z)
@StimSize1 = qw( 0 1.02 0 );
@StimSize2 = qw( 0 0 0 );

# Aspect Ratio of the whole image (frame): x/y
$AspRat = 320/240;
# Image resolution
$xres = 300; #1100;
$yres = int( $xres / $AspRat );

# Look if other analyses were performed before (i.e., if other folders BlobSet exist)
$SearchWord = $BaseFolderName . "*";
@FileList = glob $SearchWord;
$N_BlobFolders = @FileList;

if( $N_BlobFolders > 0 ){

    # Ask the user what ot do
    print "There are already $N_BlobFolders existing folders containing Blobs\n";
    print "Choose action: ";
    print "\t [O]verwrite last folder";
    print "\t [M]ake a new folder";
    print "\t [Q]uit\n";
    chomp( $reply = <STDIN> );
    
    # Delete all files in the last folder and use it as destination folder for the new files
    if( lc( $reply ) eq "o" ){
        $OutputFolder = $FileList[$#FileList];
        $copystring = "rm $FileList[$#FileList]" . "/Blob*.*";
        print "$copystring\n";
        system($copystring);
        print "Save new blobs in $OutputFolder\n";
    } 
    # Create a new folder for the new blobs
    elsif( lc( $reply ) eq "m" ) {
        $N_BlobFolders++;
        $OutputFolder = "${BaseFolderName}${N_BlobFolders}";
        $copystring = "mkdir $OutputFolder";
        print "$copystring\n";
        system($copystring);
        print "Save new blobs in $OutputFolder\n";
    }
    # Exit the script
    else{
        print "Exiting the script\n";
        exit;
    }
 } 
 # Create a new folder for the new blobs
 else {
    $N_BlobFolders++;
    $OutputFolder = "$BaseFolderName$N_BlobFolders";
    $copystring = "mkdir $OutputFolder";
    print "$copystring\n";
    system($copystring);
    print "Save new blobs in $OutputFolder\n";
 }



# Loop on the number of stimuli
for( $i=1; $i<=$n_stim; $i++ ){
    print "\n";
    print "------ Start stimulus num. $i --------\n";
   # Initialize the command string for the next blob
    $commandstring = "povray $POVray_script_BaseName$i.pov Display=false +W$xres +H$yres ";    
    if( $i==1 ){
        $commandstring .= " Declare=obj_pos_x=$StimPos1[0] ";
        $commandstring .= " Declare=obj_pos_y=$StimPos1[1] ";
        $commandstring .= " Declare=obj_pos_z=$StimPos1[2] ";
        $commandstring .= " Declare=obj_scale_x=$StimSize1[0] ";
        $commandstring .= " Declare=obj_scale_y=$StimSize1[1] ";
        $commandstring .= " Declare=obj_scale_z=$StimSize1[2] ";    
    }
    else{
        $commandstring .= " Declare=obj_pos_x=$StimPos2[0] ";
        $commandstring .= " Declare=obj_pos_y=$StimPos2[1] ";
        $commandstring .= " Declare=obj_pos_z=$StimPos2[2] ";    
        $commandstring .= " Declare=obj_scale_x=$StimSize2[0] ";
        $commandstring .= " Declare=obj_scale_y=$StimSize2[1] ";
        $commandstring .= " Declare=obj_scale_z=$StimSize2[2] ";    
    }
    $commandstring_run = "";    
    
    
    $z_rot = 0;
    # Loop on the camera rotations around the y and x axis (in this order) to generate for the current blob
    # Note: that the order of the rotations does matter. Rotations occur about the x-axis first, then the y-axis, then the z-axis. 
    # If you are not sure if this is what you want then you should only rotate on one axis at a time using multiple rotation statements to get a correct rotation.
    for( $y_rot=$RotStart_y; $y_rot <= $RotEnd_y; $y_rot=$y_rot+$RotStep_y ){
        for( $x_rot=$RotStart_x; $x_rot <= $RotEnd_x; $x_rot=$x_rot+$RotStep_x ){
    
            # Start fresh with the command string which is common to every object view
            $commandstring_run = $commandstring;
            
            $commandstring_run .= " Declare=cam_rot_y=$y_rot ";
            $commandstring_run .= " Declare=cam_rot_x=$x_rot ";
            $commandstring_run .= " Declare=cam_rot_z=$z_rot ";
            
            # Print final transformations
            print   "Rotation x: $x_rot\n" .
                    "Rotation y: $y_rot\n" .
                    "Rotation z: $z_rot\n";
                                    
            # Call povray
            print "\n$commandstring_run\n";
            system($commandstring_run);
            
            # Rename the file and copy into another folder
            $newname = "Blob_${i}_CamRot_y${y_rot}_CamRot_x${x_rot}";				
            $copystring = "cp ${POVray_script_BaseName}${i}.png ./${OutputFolder}/${newname}.png";
            print "$copystring\n";
            system($copystring);            
        } #for x_rot
    } #for y_rot

} #for i





