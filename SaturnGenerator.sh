#!/bin/bash

INFO_FILE=$1
DATE_YEAR=$2
DATE_LENGTH=$3
OUTPUT_FILE=$4
ASTROLOG='/home/atari911/Downloads/astrolog/astrolog'

function MAIN
{
if [ $INFO_FILE = "help" 2>/dev/null ]; then
	printf "HELP! - SaturnGenerator.sh help file:
------------------------------------------------------------------\n
SaturnGenerator.sh (file-in) (year) (length) (file-out)

Usage: 
------------------------------------------------------------------
This script will generate all of the Saturn tranits for 
the info file inserted as the first argument for the year(s) entered 
as the second argument. The length of time you would like to get
the Saturn transits for is the third arg. Then finally enter the
file that you would like to output.\n
Example: 
------------------------------------------------------------------
./SaturnGenerator.sh ~/Astrology/Jason.Spohn/Info.Jason 2016 10 file\n
This will print the Saturn transits to the natal listed for the
year of 2016 on forward for 10 years. The file named 'file' will be
created with only the Saturn transits listed.\n
Notes:
------------------------------------------------------------------
* To get back to this message, use 'help' as the first argument.
* Script created by Jason Spohn (atari911). Feel free to share!
* Big thank you to 'Astrolog' for making this all possible!\n\n"
>&2; exit 1
else 
	printf "\nSaturnGenerator.sh help   <-For usage info!\n\n"
fi

if ! [[ $DATE_YEAR =~ ^-?[0-9]+$ ]] ; then
	printf "\nERROR: You must enter a number as the second argument!\n" >&2; exit 1
fi

if [ $INFO_FILE = "show" 2>/dev/null ]; then
	echo $INFO_FILE
	echo $DATE_YEAR
	echo $OUTPUT_FILE
	echo $DATE_LENGTH
	echo $ASTROLOG
>&2; exit 1
fi

$ASTROLOG -i $INFO_FILE -tY $DATE_YEAR $DATE_LENGTH -os /tmp/astrolog.script
sed -i '/Vesta/d' /tmp/astrolog.script
sed -i '/Lilith/d' /tmp/astrolog.script
sed -i '/Ceres/d' /tmp/astrolog.script
sed -i '/Juno/d' /tmp/astrolog.script
sed -i '/Fortune/d' /tmp/astrolog.script
sed -i '/Vertex/d' /tmp/astrolog.script
sed -i '/Pallas/d' /tmp/astrolog.script
sed -i '/Chiron/d' /tmp/astrolog.script
sed -i '/Node/d' /tmp/astrolog.script
sed -i '/East/d' /tmp/astrolog.script

grep -i saturn /tmp/astrolog.script > $OUTPUT_FILE

sed -i '/Saturn$/d' $OUTPUT_FILE

sed -i "1i ####################################################################\n" $OUTPUT_FILE
sed -i "1i Start year: $DATE_YEAR Length: $DATE_LENGTH year" $OUTPUT_FILE
sed -i "1i Saturn Transits for $INFO_FILE" $OUTPUT_FILE

rm /tmp/astrolog.script

}

MAIN
