#!/bin/sh


echo 'Distributed to Mac Pro'
./distributed_render.py --user="labuser" \
                        --host="10.170.2.173" \
                        --n=8 \
                        --povfile="output2.pov" \
                        --remotedir="~/Desktop" \
                        --povargs="" \
                        --width=1024 \
                        --height=800 \
                        --outname="stiched_remote.png" \
                        --povargs="+A0.5 +Q8"
rm -rf /tmp/*.ppm
                        
echo 'Distributed locally'

./distributed_render.py --user="labuser" \
                        --host="10.163.8.2" \
                        --n=2 \
                        --povfile="output2.pov" \
                        --remotedir="~/Desktop" \
                        --povargs="" \
                        --width=1024 \
                        --height=800 \
                        --outname="stiched_local.png" \
                        --povargs="+A0.5 +Q8"
rm -rf /tmp/*.ppm

echo 'Distributed Both'
./distributed_render.py --user="labuser" \
                        --host="10.170.2.173,10.163.8.2" \
                        --n="8,2" \
                        --povfile="output2.pov" \
                        --remotedir="~/Desktop" \
                        --povargs="" \
                        --width=1024 \
                        --height=800 \
                        --outname="stiched_distributed.png" \
                        --povargs="+A0.5 +Q8"
rm -rf /tmp/*.ppm