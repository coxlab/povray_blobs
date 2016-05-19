#!/usr/bin/perl -w
#
# This script will write and execute a command line call to POVRAY
# to generate 4 lobes blobs
# It works by calling the pov script FourLobesBlob

$n_iter = 5;    # number of iterations
$n_spheres = 4;      # number of spheres in the blob
$POVray_script = "FourLobesBlob";   # POVray application that must be called from the command line
$BaseScaleFact = 0.5;
$MaxScaleFact = 1;
$MaxTranslationFact = 0.5;
$OutputFolder = "BlobSet";
$BaseFolderName = "BlobSet";

# Aspect Ratio of the whole image (frame): x/y
$AspRat = 320/240;
# Image resolution
$xres = 300; #1200;
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
    $OutputFolder = $BaseFolderName;
    $copystring = "mkdir $OutputFolder";
    print "$copystring\n";
    system($copystring);
    print "Save new blobs in $OutputFolder\n";
 }


# Open the file that will contain the info about the blobs parameters
open( INFO_FILE, '>BlobInfo.txt' );

# Loop on the required iterations (# of blobs to generate)
for( $i=0; $i<$n_iter; $i++ ){
    print "\n";
    # Initialize the command string for the next blob
    $commandstring = "povray $POVray_script.pov Display=false +W$xres +H$yres ";
    @radius = ();
    @translation_x = ();
    @translation_y = ();
    @translation_z = ();
    @scale_x = ();
    @scale_y = ();
    @scale_z = ();
    @rotation_x = ();
    @rotation_y = ();
    @rotation_z = ();
    
    ######## THRESHOLD ########
    # Sample the magnitude of the transformation
    $threshold = sprintf( "%.2f", 0.2+rand(0.2) );
    $commandstring .= " Declare=thr=$threshold ";        
            
    for( $i_sph=0; $i_sph<$n_spheres; $i_sph++ ){
        
        $count = $i_sph+1;
        
        ######## RADIUS X ########
        # Sample the magnitude of the transformation
        $radius[$i_sph] = sprintf( "%.2f", 0.5+rand(0.5) );
        $commandstring .= " Declare=rad_${count}=$radius[$i_sph] ";        
        
        ######## TRANSLATION X ########
        # Sample the sign of the transformation
        $sign = int( rand( 2 ) );
        if( $sign == 0 ){
            $sign = -1;
        }
        # Sample the magnitude of the transformation
        $translation_x[$i_sph] = sprintf( "%.2f", $sign*rand($MaxTranslationFact) );
        $commandstring .= " Declare=tr_${count}_x=$translation_x[$i_sph] ";        
        
        ######## TRANSLATION Y ########
        # Sample the sign of the transformation
        $sign = int( rand( 2 ) );
        if( $sign == 0 ){
            $sign = -1;
        }
        # Sample the magnitude of the transformation
        $translation_y[$i_sph] = sprintf( "%.2f", $sign*rand($MaxTranslationFact) );
        $commandstring .= " Declare=tr_${count}_y=$translation_y[$i_sph] ";    
        
        ######## TRANSLATION Z ########
        # Sample the sign of the transformation
        $sign = int( rand( 2 ) );
        if( $sign == 0 ){
            $sign = -1;
        }
        # Sample the magnitude of the transformation
        $translation_z[$i_sph] = sprintf( "%.2f", $sign*rand($MaxTranslationFact) );
        $commandstring .= " Declare=tr_${count}_z=$translation_z[$i_sph] ";    
                    
        ######## SCALE X ########
        # Sample the magnitude of the transformation
        $scale_x[$i_sph] = sprintf( "%.2f", $BaseScaleFact+rand($MaxScaleFact) );
        $commandstring .= " Declare=sc_${count}_x=$scale_x[$i_sph] ";        
        
        ######## SCALE Y ########
        # Sample the magnitude of the transformation
        $scale_y[$i_sph] = sprintf( "%.2f", $BaseScaleFact+rand($MaxScaleFact) );
        $commandstring .= " Declare=sc_${count}_y=$scale_y[$i_sph] ";       
        
        ######## SCALE Z ########
        # Sample the magnitude of the transformation
        $scale_z[$i_sph] = sprintf( "%.2f", $BaseScaleFact+rand($MaxScaleFact) );
        $commandstring .= " Declare=sc_${count}_z=$scale_z[$i_sph] ";       
        
        ######## ROTATION X ########
        # Sample the magnitude of the transformation
        $rotation_x[$i_sph] = int(rand(360));
        $commandstring .= " Declare=rot_${count}_x=$rotation_x[$i_sph] ";        
          
        ######## ROTATION Y ########
        # Sample the magnitude of the transformation
        $rotation_y[$i_sph] = int(rand(360));
        $commandstring .= " Declare=rot_${count}_y=$rotation_y[$i_sph] ";        
          
        ######## ROTATION Z ########
        # Sample the magnitude of the transformation
        $rotation_z[$i_sph] = int(rand(360));
        $commandstring .= " Declare=rot_${count}_z=$rotation_z[$i_sph] ";        
                    
    } #for itr
    
    # Print final transformations
    print   "Threshold: $threshold\n" .
            "Radius: @radius\n" .
            "Translation x: @translation_x\n" .
            "Translation y: @translation_y\n" .
            "Translation z: @translation_z\n" .
            "Scale x: @scale_x\n" .
            "Scale y: @scale_y\n" .
            "Scale z: @scale_z\n" .
            "Rotation x: @rotation_x\n" .
            "Rotation y: @rotation_y\n" .
            "Rotation z: @rotation_z\n";
                            
    # Call povray
    print "\n$commandstring\n";
    system($commandstring);
    
    # Rename the file and copy into another folder
    $newname = "Blob_" . "$i";				
    $copystring = "cp $POVray_script.png ./${OutputFolder}/${newname}.png";
    print "$copystring\n";
    system($copystring);
    
    # Print all infos about blobs in an info file
    print   INFO_FILE "$newname\n".
            "Threshold: $threshold\n" .
            "Radius: @radius\n" .
            "Translation x: @translation_x\n" .
            "Translation y: @translation_y\n" .
            "Translation z: @translation_z\n" .
            "Scale x: @scale_x\n" .
            "Scale y: @scale_y\n" .
            "Scale z: @scale_z\n" .
            "Rotation x: @rotation_x\n" .
            "Rotation y: @rotation_y\n" .
            "Rotation z: @rotation_z\n\n";    
    
} #for i

close INFO_FILE;
$copystring = "mv BlobInfo.txt ./${OutputFolder}/";
print "$copystring\n";
system($copystring);


