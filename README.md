# video_2d_to_3d

unfinished

its using an older version of midas and the 3d effect its pretty tame

1- install anaconda

2- conda create -n midas_test python=3.7.7

3- conda create --name <env> --file requirements.txt
   
4- install imagemagick
 
5- conda activate midas_test

6- ./main.sh [filename]

7- once the video is done the converted frames are goin to be stored in the /final directory

8- you can use ./unir_frames.sh to join them in a videofile

repositories used

https://github.com/otwen/depth2stereo

https://github.com/intel-isl/MiDaS
