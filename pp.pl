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

#parse options
GetOptions('help|h' => \$help,
    'm' => \$htmloutput,
    'f=s@' => \@filenames);

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
    	print("-m ............. Output location info to HTML file\n");

    	print("\nExamples:\n==========\n\n");
	print("pp.pl -f image.jpg");
    	print("\nExample: pp.pl -f image.jpg -f /examples/RIT.jpg -html\n\n");
    	    
    	exit;
}

foreach my $name (@filenames)
{
    my $file = shift;

    #check to see if the file exists
    if (-e $filename)
    {
    	my $exif = Image::ExifTool->new()
    	
    	if($exif = ExtractInfo($file);
    }
}
