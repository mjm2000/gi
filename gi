#!/bin/sh
function time_op(){
    sec1=$(timeconv -s $1)
    sec2=$(timeconv -s $2)
    diff=$(echo "$sec2 - $sec1"|bc)
    echo $(timeconv -ts $diff)
}
time1=$1
time2=$(time_op $1  $2)    

echo $time2

cur_dir=$PWD

youtube-dl -f mp4 $3 && file=$(youtube-dl --get-filename -f mp4 $3)  

echo $file 

ffmpeg -ss $time1 -i "$file" -to $time2 -c copy output.mp4

#mv output.mp4 $cur_dir 
