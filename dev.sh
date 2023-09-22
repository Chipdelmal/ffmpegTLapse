#!/bin/bash

###############################################################################
# Constants
###############################################################################
CRED='\033[0;31m'
CGRN='\033[0;32m'
CPRP='\033[0;35m'
COFF='\033[0m'
# FFMPEG ----------------------------------------------------------------------
TUNE="film"
PRESET="slow"
CRF=20
###############################################################################
# Parse arguments
###############################################################################
# Presets ---------------------------------------------------------------------
FNAME=""
OVERWRITE='n'
VERBOSE='error'
FRATE='30'
BPATH=~/Pictures/GoPro
ANGLE="1440x1080"
EXTENSION="JPG"
DEBUG="False"
# Help message ----------------------------------------------------------------
print_usage() {
  printf "$CRED
  * Mandatory argument:
    \t -f: Folder/File name
  * Optional arguments:
    \t -p: Filepath (default: '~/Pictures/GoPro/')
    \t -r: Frame rate for output video (default: 30)
    \t -v: Verbose ('panic', 'warning', default: 'error')
  * Optional flags:
    \t -y: Overwrite present video files (off by default).
    \t -w: Wide-angle fimelapse (linear by default).
    \t -d: Dev debugging flag to print inputs and skip run (off by default).$COFF\n
  "
}
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
# Print for debugging ---------------------------------------------------------
if [ "$DEBUG" = "True" ]; then
    printf "$CPRP[-d] Debug: $DEBUG
[-y] Overwrite: $OVERWRITE
[-v] Verbose: $VERBOSE
[-r] Framerate:  $FRATE
[-w] Angle: $ANGLE
[-p] Path: $BPATH 
[-f] Filename: $FNAME $COFF\n"
    exit 0
fi
# Exit if filename was not provided -------------------------------------------
if [ "$FNAME" = "" ]; then
    printf "$CRED Filename not provided, please provide the foldername with the -f flag! $COFF"
    exit 0
fi
# Working directories ---------------------------------------------------------
CDIR="$PWD"
MDIR="${BPATH}/${FNAME}"
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