#!/bin/bash

generate_depth(){
  path=$(pwd)
  cd tmp
  for filename in `ls -v *.png`
  do
    filename2=$(basename $filename .png)
    convert -resize 640x480! $filename $filename2.jpg
    rm $filename
    mv $filename2.jpg $path/midas/input/
  done
  cd ..

  cd midas
  python run.py
  #read -rsp $'Press enter to continue...\n'
  cd input

  i=0
  for filename in `ls -v *.jpg`
  do
    #generate_sbs "$filename" "$i" "$path"
    basename=$(basename $filename .jpg)
    mv $path/midas/input/$filename $path/d2s/example/$i.jpg
    convert -resize 640x480! $path/midas/output/$basename.png $path/d2s/stereo/dp$i.jpg
    cd $path/midas/output
    rm $basename.png
    i=$(($i+1))
  done
  cd $path
}

generate_sbs(){
  path=$(pwd)
  cd d2s
  python test.py
  rm $path/d2s/temp/left*
  rm $path/d2s/temp/right*
  rm $path/d2s/example/*.jpg
  rm $path/d2s/stereo/*.jpg
  x=0
  for (( i=$start; i<$end; i++ ))
  do
    mv $path/d2s/temp/stereo$x.jpg $path/final/$i.jpg
    echo $i
    x=$(($x+1))
  done
  #filename=$(basename $1 .png)
  cd $path
}


total_frames=$(ffmpeg -i $1 -map 0:v:0 -c copy -f null -y /dev/null 2>&1 | grep -Eo 'frame= *[0-9]+ *' | grep -Eo '[0-9]+' | tail -1)

start=0
end=10

while (( $total_frames > 0 ))
do

  if (( $total_frames < 10 ))
  then
    end=$(($start+$asd))
    asd=0
  fi

  for (( i=$start; i<$end; i++ ))
  do
    ffmpeg -i $1 -vf select="eq(n\,$i)" -vframes 1 tmp/$i.png
  done

  generate_depth
  generate_sbs $start $end
  #read -rsp $'Press enter to continue...\n'
  total_frames=$(($total_frames-10))
  start=$(($start+10))
  end=$(($end+10))

done
