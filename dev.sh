#!/bin/bash


###############################################################################
# Constants
###############################################################################
CRED='\033[0;31m'
CPRP='\033[0;35m'
COFF='\033[0m'
# FFMPEG ----------------------------------------------------------------------
TUNE="film"
PRESET="slow"
###############################################################################
# Mandatory filename argument
###############################################################################
FNAME=$1
###############################################################################
# Optional arguments
###############################################################################
OVERWRITE='-n'
VERBOSE='error'
FRATE='30'
BPATH=~/Pictures/GoPro
ANGLE="1440x1080"
EXTENSION="JPG"
# Help message ----------------------------------------------------------------
print_usage() {
  printf "
  * Mandatory argument:
    \t -f: Folder/File name 
  * Optional arguments:
    \t -p: Filepath (default: '~/Pictures/GoPro/')
    \t -r: Frame rate for output video (default: 30)
    \t -v: Verbose ('panic', 'warning', default: 'error')
  * Optional flags:
    \t -y: Overwrite present video files (off by default).
    \t -w: Wide-angle fimelapse (linear by default).
  "
}
# Parse optional arguments ----------------------------------------------------
while getopts 'hywv:r:p:' flag; do
  case "${flag}" in
    y) OVERWRITE='-y' ;;
    p) BPATH="${OPTARG}" ;;
    v) VERBOSE="${OPTARG}" ;;
    r) FRATE="${OPTARG}" ;;
    w) ANGLE="1920x1080" ;;
    *) print_usage
       exit 1 ;;
  esac
done
# Print for debugging ---------------------------------------------------------
printf "
    Overwrite: $OVERWRITE
    Verbose: $VERBOSE
    Framerate: $FRATE
    Filename: $FNAME
    Angle: $ANGLE
    Path: $BPATH
"
###############################################################################
# Move files to same parent folder
###############################################################################
echo -e "${CRED}* Moving files to parent directory from: ${BPATH}/${FNAME} ${COFF}"
find $BPATH/$FNAME -mindepth 2 -type f \
    -exec mv {} $BPATH/$FNAME \;