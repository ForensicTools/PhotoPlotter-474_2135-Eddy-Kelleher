#!/usr/bin/perl

use strict;
use warnings;

push(@INC, "/home/toor/.cpan/build/"); 	#having issues using this


#modules to use
#use Image::ExifTool;			#issues with this module 
#use Image::ExifTool::Location;		#issues with this module
use Getopt::Long;
use HTML::QuickTable;

my $help = '';
my $htmloutput = '';
my @filenames;
my %file_listing;
my $dirPath;

#parse options
GetOptions('help|h' => \$help,
    'm' => \$htmloutput,
    'f=s@' => \@filenames),
    'd' => \$dirName;

#if help or no files given
if ($help or @filenames == 0)
{
	#print usage info
    	print("\npp.pl v1.0\n");
    	print("==========\n\n");
    	print("A tool to analyze photo(s) and print the location of them to STDOUT. It will also have an option to write the location of the photo(s) to an HTML file with links to the location on Google Maps.\n");

    	print("\nUsage:\n==========\n\n");
	print("pp.pl <options>\n\n");
	print("Options:\n==========\n\n");
    	print("-h|help ........ Show help\n");
    	print("-f filename .... File(s) to extract location info from\n");
    	print("-d dirName ..... Extract location info of files from a directory\n");
    	print("-m ............. Output location info to HTML file\n");

    	print("\nExamples:\n==========\n\n");
	print("pp.pl -f image.jpg");
    	print("\nExample: pp.pl -f image.jpg -f /examples/RIT.jpg -m\n\n");
    	    
    	exit;
}


foreach my $name (@filenames)
{
    my $file = shift;

    #check to see if the file exists
    if ( -e $filename )
    {
    	my $exif = Image::ExifTool->new()
    	
    	if( $exif = ExtractInfo($file );
    }
}

# If html AND we actually have files
if ( ( $htmloutput ) && (keys( %file_listing ) > 0 ) )
{    
    	#timestamped output filename
	my $htmloutputfile = "pp-output-".time.".html";

    	open( my $html_output_file, ">".$htmloutputfile ) || die( "Unable to open $htmloutputfile for writing\n" );

	#create HTML table
	my $htmltable = HTML::QuickTable->new( border => 1, labels => 1 );

	# Added preceding "/" to "Filename" so that the HTML::QuickTable sorting doesn't result in
	# the column headings being re-ordered after / below a filename beginning with a "\". 
	$file_listing{ "/Filename" } = "GoogleMaps Link";
	
	print $html_output_file "<HTML>"
	print $html_output_file $htmltable->render( \%file_listing );
	print $html_output_file "<\/HTML>";
	
	close( $htmloutputfile );
}

ub ProcessFilename
{
	my $filename = shift;
	
	if (-e $filename) #file must exist
	{
	 	my $exif = Image::ExifTool->new();
	        # Extract all info from existing image
	        if ($exif->ExtractInfo($filename))
	        {
	            # Ensure all 4 GPS params are present 
	            # ie GPSLatitude, GPSLatitudeRef, GPSLongitude, GPSLongitudeRef
	            # The Ref values indicate North/South and East/West
	            if ($exif->HasLocation()) 
	            {
	              	my ($lat, $lon) = $exif->GetLocation(); 
	                
	                print("\n$filename contains Lat: $lat, Long: $lon\n");
	                print("URL: http://maps.google.com/maps?q=$lat,+$lon($filename)&iwloc=A&hl=en\n");
	                
	                if ($htmloutput) # save GoogleMaps URL to global hashmap indexed by filename
	                {
	                    $file_listing{$filename} = "<A HREF = \"http://maps.google.com/maps?q=$lat,+$lon($filename)&iwloc=A&hl=en\"> http://maps.google.com/maps?q=$lat,+$lon($filename)&iwloc=A&hl=en</A>";
	                }
	                
	                return 1;
