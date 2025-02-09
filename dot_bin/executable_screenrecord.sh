#!/bin/bash
if pgrep -x wf-recorder &> /dev/null ; then
    pkill wf-recorder
else
    wf-recorder -g "$(slurp)" -c libx265 -C libvorbis --audio=bluez_output.C0_28_8D_00_59_13.1.monitor -f ~/Videos/screen-recordings/screen-record-"$(date +%Y-%m-%d-%H-%M-%S)".mkv
fi