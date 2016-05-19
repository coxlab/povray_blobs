#!/usr/bin/perl -w
#
# This script will write and execute a command line call to POVRAY
# to generate multiple views of the two hand made stimuli StimBlob 1 and 2.
# It differs from the original "Script_StimBlob.pl", because it allows rendering not only different
# views of the blob objects but also different lighting conditions (i.e., positions of the light dource).
# It works by calling the pov scripts StimBlob_lighting_call_1.pov and StimBlob_lighting_call_2.pov

$POVray_script_BaseName = "StimBlob_lighting_call_";   # POVray application that must be called from the command line
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
#@CamRot_x = qw(  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0    0       0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0);
#@CamRot_y = qw( -90 -85 -80 -75 -70 -65 -60 -55 -50 -45 -40 -35 -30 -25 -20 -15 -10 -5    0       5  10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90);
#@CamRot_z = qw(  0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0    0       0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0);

# New rotations for testing the generalization of D1 & D2 with the transformation matrix
@CamRot_x = qw(  0   0   0   0  0  0  0  0  0);
@CamRot_y = qw( -60 -45 -30 -15 0 15 30 45 60);
@CamRot_z = qw(  0   0   0   0  0  0  0  0  0);

# Positions of the light source (NOTE: the light position of the original blob training stims was: [0 -10 -10])
#@LightPos_x = qw(   0   0       -10     -10     -10     10     10     10);
#@LightPos_y = qw(   10  0        0       10     -10     0       10     -10);
#@LightPos_z = qw(  -10 -10      -10     -10     -10     -10     -10     -10);

# Positions of the light source (NOTE: the light position of the original blob training stims was: [0 -10 -10])
@LightPos_x = qw(   0   0  10 );
@LightPos_y = qw( -10  10   0 );
@LightPos_z = qw( -10 -10 -10 );

# Position of the light source (this allow rendering a single position)
#@LightPos_x = qw(   0   );
#@LightPos_y = qw(   -10  );
#@LightPos_z = qw(  -10 );

# number of camera rotations and light positions
$n_CamRot = @CamRot_x; 
$n_LightPos = @LightPos_x;   

# Location of the whole object/stimulus (x,y,z)
@StimPos1 = qw( 0 -0.18 5 );
@StimPos2 = qw( 0 0 6 );
# Size of the whole object/stimulus (x,y,z)
@StimSize1 = qw( 0 1.02 0 );
@StimSize2 = qw( 0 0 0 );

# Aspect Ratio of the whole image (frame): x/y
$AspRat = 320/240;
# Image resolution
$xres = 1100;
$yres = int( $xres / $AspRat );

# Look if other analyses were performed before (i.e., if other folders BlobSet exist)
$SearchWord = $BaseFolderName . "*";
@FileList = glob $SearchWord;
$N_BlobFolders = @FileList;

if( $N_BlobFolders > 0 ){

    # Ask the user what to do
    print "There are already $N_BlobFolders existing folders containing Blobs\n";
    print "Choose action: ";
    print "\t [O]verwrite last folder";
    print "\t [A]dd to the last folder";
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
    # Add the new files to the last folder (useful if blobs 2 are generated after blobs 1 and we want to place them in the same folder of blobs 1)
    elsif( lc( $reply ) eq "a" ) {    
        $OutputFolder = $FileList[$#FileList];
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
    
    # Loop on the lighting conditions (light positions)
    for( $i_lpos=0; $i_lpos < $n_LightPos; $i_lpos++ ){
    
        # Loop on the views (camera rotations) to generate for the current blob
        for( $i_crot=0; $i_crot < $n_CamRot; $i_crot++ ){
            # Start fresh with the command string which is common to every object view
            $commandstring_run = $commandstring;
            
            $commandstring_run .= " Declare=light_pos_x=$LightPos_x[$i_lpos] ";
            $commandstring_run .= " Declare=light_pos_y=$LightPos_y[$i_lpos] ";
            $commandstring_run .= " Declare=light_pos_z=$LightPos_z[$i_lpos] ";
            
            #@AllCamRot = ( $CamRot_x[$i_crot], $CamRot_y[$i_crot], $CamRot_z[$i_crot] );
            $commandstring_run .= " Declare=cam_rot_x=$CamRot_x[$i_crot] ";
            $commandstring_run .= " Declare=cam_rot_y=$CamRot_y[$i_crot] ";
            $commandstring_run .= " Declare=cam_rot_z=$CamRot_z[$i_crot] ";    
            
            # Print final transformations
            print   "Rotation x: $CamRot_x[$i_crot]\n" .
                    "Rotation y: $CamRot_y[$i_crot]\n" .
                    "Rotation z: $CamRot_z[$i_crot]\n" .
                    "Ligh Position x: $LightPos_x[$i_lpos]\n" .
                    "Ligh Position y: $LightPos_y[$i_lpos]\n" .
                    "Ligh Position z: $LightPos_z[$i_lpos]\n";
                                    
            # Call povray
            print "\n$commandstring_run\n";
            system($commandstring_run);
            
            # Rename the file and copy into another folder (create a new subfolder for each lighting condition)           
            $OutputSubFolder = "LightPos_x$LightPos_x[$i_lpos]_y$LightPos_y[$i_lpos]_z$LightPos_z[$i_lpos]";
            
            $SearchWord = "$OutputFolder/$OutputSubFolder*";
            @FileList = glob $SearchWord;
            print "@FileList \n";
            $N_BlobFolders = @FileList;
            print "$N_BlobFolders \n";
            if( $N_BlobFolders == 0 ){
                $copystring = "mkdir $OutputFolder/$OutputSubFolder";
                print "$copystring\n";
                system($copystring);
                print "Create subfolder for light position: x=$LightPos_x[$i_lpos]; y=$LightPos_y[$i_lpos]; z=$LightPos_z[$i_lpos] \n";
            }
            
            $newname = "Blob_${i}_CamRot_y$CamRot_y[$i_crot]_LighPos_x$LightPos_x[$i_lpos]_y$LightPos_y[$i_lpos]_z$LightPos_z[$i_lpos]";
            $copystring = "cp ${POVray_script_BaseName}${i}.png ./${OutputFolder}/${OutputSubFolder}/${newname}.png";
            print "$copystring\n";
            system($copystring);            
        } #for i_crot
        
    } #for $i_lpos

} #for i
