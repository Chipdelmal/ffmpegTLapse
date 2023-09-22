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

print_debug() {
    printf "$CPRP[-d] Debug: $DEBUG
[-y] Overwrite: $OVERWRITE
[-v] Verbose: $VERBOSE
[-r] Framerate:  $FRATE
[-w] Angle: $ANGLE
[-p] Path: $BPATH 
[-f] Filename: $FNAME $COFF\n"
}

print_filename() {
    printf "$CRED Filename not provided, please provide the foldername with the -f flag! $COFF"
}