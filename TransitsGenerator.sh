#!/bin/bash

INFO_FILE=$1
DATE_YEAR=$2
DATE_LENGTH=$3
OUTPUT_FILE=$4
ASTROLOG='/home/atari911/Downloads/astrolog/astrolog'
END_YEAR=$(($DATE_YEAR + $DATE_LENGTH))

function MAIN
{

# Check if the first argument is 'help'. Print the help file
if [ $INFO_FILE = "help" 2>/dev/null ]; then
	printf "HELP! - SaturnGenerator.sh help file:
------------------------------------------------------------------
TransitsGenerator.sh (info-file) (year) (length) (file-out)

Usage: 
------------------------------------------------------------------
This script will generate all of the tranits for the info file 
inserted as the first argument for the year(s) entered as the 
second argument. The length of time you would like to get the 
transits for is the third arg. Then finally enter the file that 
------------------------------------------------------------------
./TransitGenerator.sh ~/Astrology/Jason.Spohn/Info.Jason 2016 10 file\n
This will print the transits to the natal listed for the
year of 2016 on forward for 10 years. The file named 'file' will be
created with the transits listed.\n
Notes:
------------------------------------------------------------------
* To get back to this message, use 'help' as the first argument.
* Script created by Jason Spohn (atari911). Feel free to share!
* Big thank you to 'Astrolog' for making this all possible!\n\n"
>&2; exit 1
# If nothing else, print the following hint
else 
	printf "\nTransitGenerator.sh help   <-For usage info!\n\n"
fi

# Check if the second argument is numerical. 
if ! [[ $DATE_YEAR =~ ^-?[0-9]+$ ]] ; then
	printf "\nERROR: You must enter a number as the second argument!\n" >&2; exit 1
fi

# A little debuging information is shown if 'show' is the first arg
if [ $INFO_FILE = "show" 2>/dev/null ]; then
	echo $INFO_FILE
	echo $DATE_YEAR
	echo $OUTPUT_FILE
	echo $DATE_LENGTH
	echo $ASTROLOG
>&2; exit 1
fi

# Run the actual command that does the main work
$ASTROLOG -i $INFO_FILE -tY $DATE_YEAR $DATE_LENGTH -os $OUTPUT_FILE

# Remove asteroids and points that I do not use.
# There is probrably a switch in 'astrolog' that will remove these.
sed -i '/Vesta/d' $OUTPUT_FILE
sed -i '/Lilith/d' $OUTPUT_FILE
sed -i '/Ceres/d' $OUTPUT_FILE
sed -i '/Juno/d' $OUTPUT_FILE
sed -i '/Fortune/d' $OUTPUT_FILE
sed -i '/Vertex/d' $OUTPUT_FILE
sed -i '/Pallas/d' $OUTPUT_FILE
sed -i '/Chiron/d' $OUTPUT_FILE
sed -i '/Node/d' $OUTPUT_FILE
sed -i '/East/d' $OUTPUT_FILE

# Add a nice little header to the file
sed -i "1i ####################################################################\n" $OUTPUT_FILE
sed -i "1i Start year: $DATE_YEAR End year: $END_YEAR Length: $DATE_LENGTH year" $OUTPUT_FILE
sed -i "1i Transits for $INFO_FILE" $OUTPUT_FILE

}

MAIN
