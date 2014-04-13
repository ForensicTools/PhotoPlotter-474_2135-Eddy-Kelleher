PhotoPlotter-474_2135-Eddy-Kelleher

PhotoPlotter is distributed under the terms of the GNU General Public License.

Copyright (C) 2014 John Kelleher, Joshua Eddy
 
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.


pp.pl v1.0
==========

A tool to analyze photo(s) and print the location of them to STDOUT. It will also have an option to write the location of the photo(s) to an HTML file with links to the location on Google Maps.

Usage:
==========

-pp.pl <options>

Options:
==========

-h|help ........ Show help

-f filename .... File(s) to extract location info from

-d dirname ..... Directory to extract files from

-m ............. Output location info to HTML file

Examples: 
==========

-pp.pl -f image.jpg

-pp.pl -f image.jpg -f /examples/RIT.jpg -html
