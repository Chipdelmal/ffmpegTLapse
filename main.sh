#!/bin/bash


FNAME="Test"
BPATH="/Users/sanchez.hmsc/Pictures/GoPro"
FRATE=30
OVW="True"


CDIR="$PWD"
###############################################################################
# Terminal constants
###############################################################################
CRED='\033[0;31m'
COFF='\033[0m' 
###############################################################################
# GoPro Constants
###############################################################################
ANG_WIDE="1920x1080"
ANG_LINR="1440x1080"
EXTENSION="JPG"
###############################################################################
# Move files to same parent folder
###############################################################################
echo -e "${CRED}* Moving files to parent directory from: ${BPATH}/${FNAME} ${COFF}"
find "$BPATH"/"$FNAME" -mindepth 2 -type f -exec mv {} "$BPATH"/"$FNAME" \;
###############################################################################
# Generate video
###############################################################################
echo -e "${CRED}* Generating video to: ${BPATH}/${FNAME} ${COFF}"
cd "${BPATH}/${FNAME}"
echo $PWD
ffmpeg -pattern_type glob -i "*.JPG" \
    -r $FRATE \
    -s $ANG_LINR \
    -tune film \
    -preset slow \
    -vcodec h264 "$FNAME.mp4" \
    -y
cd $CDIR