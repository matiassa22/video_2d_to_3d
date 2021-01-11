#!/bin/bash

ffmpeg -y -start_number 0 -i "final/%d.jpg" -c:v libx264 -r 24.97 -pix_fmt yuv420p final/output.mp4