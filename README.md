# ffmpegTLapse

These scripts generate timelapse videos from GoPro Session 5 photos. Please have a look at my [blogpost](https://chipdelmal.github.io/artsci/) for more information!

## Instructions

This script requires [ffmpeg](https://ffmpeg.org/) installed in your system, so please follow their [installation instructions](https://ffmpeg.org/download.html) before using the code.

By default, the script will go to the `~/Pictures/GoPro` directory to look for the folder name provided with the `-f` tag. For example, given the following path structure:

```
~
    Pictures
        GoPro
            DCIM
                144GOPRO
                    G0014667.JPG
                    G0014668.JPG
                    ...
                    G0014987.JPG
                145GOPRO
                146GOPRO
                ...
                165GOPRO
```

we could run the script as follows:

```bash
bash main.sh -f "DCIM"
```

and it would move all our nested images to the `DCIM` folder and export our MP4 timelapse video in `~/Pictures/GoPro/DCIM/DCIM.mp4`. Which would be equivalent to running:


```bash
bash main.sh -f "DCIM" -p "~/Pictures/GoPro"
```

Different paths can be provided with this `-p` flag, and additional flags for the script are:

```
[-f] Foldername: Base name of the folder in which the ___GOPRO folders containing the images are stored (REQUIRED)
[-p] Path: Path in which our base folder is located (default: ~/Pictures/GoPro)
[-y] Overwrite: Overwrite existing files (off by default)
[-v] Verbose: Print ffmpeg processing messages ('panic', 'warning', default: 'error')
[-r] Framerate: Framerate for the timelapse video (default: 30)
[-w] Angle: If provided, uses 1920x1080 resolution for wide angle, instead of 1440x1080 (off by default)
[-h] Help: Print flags help message.
[-d] Debug: Dev flag to print provided args and skip processing.
```


## Sources

* https://rodrigopolo.github.io/GoProCalc/
* https://marketsplash.com/tutorials/bash-shell/bash-shell-arguments/
* https://ffmpeg.org/ffmpeg.html#Main-options
* https://stackoverflow.com/questions/7069682/how-to-get-arguments-with-flags-in-bash
* https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux