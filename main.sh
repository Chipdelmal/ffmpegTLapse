#!/bin/bash


FNAME="LA_south"
BPATH="/Users/sanchez.hmsc/Pictures/GoPro"
FRATE=$((30))
TLAPSE=$((1))
OVW="True"

###############################################################################
# Working directories
###############################################################################
CDIR="$PWD"
MDIR="${BPATH}/${FNAME}"
###############################################################################
# Constants
###############################################################################
CRED='\033[0;31m'
CPRP='\033[0;35m'
COFF='\033[0m' 
# GoPro Constants -------------------------------------------------------------
ANG_WIDE="1920x1080"
ANG_LINR="1440x1080"
EXTENSION="JPG"
# FFMPEG ----------------------------------------------------------------------
TUNE="film"
PRESET="slow"
###############################################################################
# Move files to same parent folder
###############################################################################
echo -e "${CRED}* Moving files to parent directory from: ${BPATH}/${FNAME} ${COFF}"
find "$BPATH"/"$FNAME" -mindepth 2 -type f -exec mv {} "$BPATH"/"$FNAME" \;
###############################################################################
# Generate video
###############################################################################
echo -e "${CRED}* Compiling video to: ${BPATH}/${FNAME}.mp4 ${COFF}"
cd $MDIR
ffmpeg -pattern_type glob -i "*.JPG" \
    -r $FRATE \
    -s $ANG_LINR \
    -tune $TUNE \
    -preset $PRESET \
    -vcodec h264 "${BPATH}/${FNAME}.mp4" \
    -hide_banner -loglevel error \
    -y 
cd $CDIR
###############################################################################
# Postprocess video
###############################################################################
echo -e "${CRED}* Postprocessing to: ${BPATH}/${FNAME}-PP.mp4 ${COFF}"
ffmpeg -i "${BPATH}/${FNAME}.mp4" \
    -vf pp=al "${BPATH}/${FNAME}-PP.mp4" \
    -hide_banner -loglevel error \
    -y
###############################################################################
# Timer calculation
###############################################################################
# FNUM=$(($(find $MDIR -name "*.JPG" -type f | wc -l)))
# echo -e "${CRED}* Calculating timer variables ${COFF}"
# echo -e "${CPRP}\t - ${FNUM} frames at a ${TLAPSE} second timing ${COFF}"