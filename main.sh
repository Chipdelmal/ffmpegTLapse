#!/bin/bash

###############################################################################
# Constants and arguments
###############################################################################
. constants.env
source ./functions.sh
# Parse optional arguments ----------------------------------------------------
while getopts 'dhywv:r:p:f:' flag; do
  case "${flag}" in
    y) OVERWRITE='y' ;;
    p) BPATH="${OPTARG}" ;;
    f) FNAME="${OPTARG}" ;;
    v) VERBOSE="${OPTARG}" ;;
    r) FRATE="${OPTARG}" ;;
    w) ANGLE="1920x1080" ;;
    d) DEBUG="True" ;;
    *) print_usage
       exit 1 ;;
  esac
done
# Check for debug and missing filename ----------------------------------------
if [ "$DEBUG" = "True" ]; then print_debug; exit 0; fi
if [ "$FNAME" = "" ]; then print_filename; exit 0; fi
###############################################################################
# Move files to same parent folder
###############################################################################
echo -e "${CGRN}[-] Moving files to parent directory from: ${BPATH}/${FNAME} ${COFF}"
find $BPATH/$FNAME -mindepth 2 -type f \
    -exec mv {} $BPATH/$FNAME \;
###############################################################################
# Generate video
###############################################################################
echo -e "${CGRN}[-] Compiling video to: ${BPATH}/${FNAME}.mp4 ${COFF}"
CDIR="$PWD"
MDIR="${BPATH}/${FNAME}"
cd $MDIR
ffmpeg -framerate $FRATE \
    -pattern_type glob -i "*.$EXTENSION" \
    -vcodec h264 $BPATH/$FNAME".mp4" \
    -r $FRATE \
    -tune $TUNE \
    -preset $PRESET \
    -hide_banner  \
    -loglevel $VERBOSE \
    -c:v libx264 \
    -crf $CRF \
    -async 1 -vsync 1 \
    -$OVERWRITE
cd $CDIR
###############################################################################
# Postprocess video
###############################################################################
echo -e "${CGRN}[-] Postprocessing to: ${BPATH}/${FNAME}-PP.mp4 ${COFF}"
ffmpeg -i $BPATH/$FNAME".mp4" \
    -vf "pp=al, scale=$ANGLE" $BPATH/$FNAME"-PP.mp4" \
    -vcodec h264 \
    -loglevel $VERBOSE \
    -hide_banner  \
    -crf $CRF \
    -async 1 -vsync 1 \
    -tune $TUNE \
    -preset $PRESET \
    -$OVERWRITE