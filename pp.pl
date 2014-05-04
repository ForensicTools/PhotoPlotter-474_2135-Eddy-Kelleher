#!/usr/bin/perl
# Unix Forensics Final Project

# Jack Kelleher & Joshua Eddy

use strict;
use warnings;

#modules to use
use Image::ExifTool;
use Image::ExifTool::Location;
use Getopt::Long;
use HTML::QuickTable;

my $help = '';
my $map = '';
my @files;
my %file_listing;

#parse flags
GetOptions('help|h' => \$help,
	'm' => \$map,
	'f=s@' => \@files);

#if help or no files listed
if($help || @files == 0)
{
	print("\npp.pl v1.0\n");
	print("Perl script to extract location info from images and plot\n"); 
	print("on Google maps if the image has stored GPS lat/long info.\n");

	print("\nUsage: pp.pl [-h|help] [-f filename] [-m]\n");
	print("-h|help ....... Prints help information for the program.\n");
	print("-f filename ... File(s) to extract lat/long from\n");
	print("-m ............ Output results to a timestamped html file in current directory\n");

	print("\nExample: pp.pl -f /pictures/example.jpg");
	print("\nExample: pp.pl -f /pictures/example.jpg -f/pictures/photo.jpg -m\n\n");
	print("Note: Outputs results to STDOUT and if specified, to timestamped html file\n");
	print("in the current directory\n\n");
	print("Nomenclature: pp-output-time.html\n\n");
    
	exit;
}


# Main processing loop
print("\npp.pl v1.0\n");

foreach my $name(@files)
{
	ProcessFile($name);
}

# If html output and photo contains location info
if(($map) && (keys(%file_listing) > 0))
{    
	#create timestamped file name
	my $mapfile = "pp-output-".time.".html";


	open(my $html_output_file, ">".$mapfile) || die("Unable to open $mapfile\n");

	my $htmltable = HTML::QuickTable->new(border => 1, labels => 1);

	# Added preceding "/" to "Filename" so that the HTML::QuickTable sorting doesn't result in
	# the column headings being re-ordered after / below a filename beginning with a "\". 
	$file_listing{"/Filename"} = "GoogleMaps Link";

	print $html_output_file "<HTML>";
	print $html_output_file $htmltable->render(\%file_listing);
	print $html_output_file "<\/HTML>";

	close($mapfile);
}

sub ProcessFile
{
	my $filename = shift;

	#check if file exists
	if (-e $filename)
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

				if ($map)
				{
				# save GoogleMaps URL to global hashmap indexed by filename
				$file_listing{$filename} = "<A HREF = \"http://maps.google.com/maps?q=$lat,+$lon($filename)&iwloc=A&hl=en\"> http://maps.google.com/maps?q=$lat,+$lon($filename)&iwloc=A&hl=en</A>";
				}
				
				return 1;
			}
			#if no location info available
			else
			{
				print("\n$filename : No location info available for this info, skipping...\n");
				return 0;
			}
		}
		#if unable to get location info
		else
		{
			print("\n$filename : Cannot extract location Info for this photo, skipping...\n");
			return 0;
		}
	}
	#if file does not exist
	else
	{
		print("\n$filename : does not exist, skipping...\n");
		return 0;
	}
}
