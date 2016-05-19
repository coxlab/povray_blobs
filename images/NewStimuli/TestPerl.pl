#!/usr/bin/perl -w
#
# This script is used to test PERL code

$OutputFolder = "BlobStim_1_2_v2";
$OutputSubFolder = "LightPos_x-10_y-10_z-10";
            
$SearchWord = "$OutputFolder/$OutputSubFolder*";
#$SearchWord = "pippo*";

@FileList = glob $SearchWord;

print "@FileList \n";
$N_BlobFolders = @FileList;
print "$N_BlobFolders \n";
