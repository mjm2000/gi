#!/bin/sh
function time_op(){
    sec1=$(timeconv -s $1)
    sec2=$(timeconv -s $2)
    diff=$(echo "$sec2 - $sec1"|bc)
    echo $(timeconv -ts $diff)
}

if [[ !($1 && $2 && $3 && $4) ]] ; then
	
	echo "Argument not supplied:" 
	echo "Usage gi \"start time\" \"end time\" \"link or file\" \"output file\""
	exit 1
fi


time1=$1
time2=$(time_op $1  $2)    

echo $time2




cur_dir=$PWD

regex='^(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]\.[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]$'

YTDL=yt-dlp
if [[  $3 =~ $regex ]]; then
	${YTDL} -f mp4 $3 && 
	file=$(${YTDL} --get-filename -f mp4 $3)  
else  
	file=$3

fi

ffmpeg -ss $time1 -i "$file"  -to $time2  -async 1 $4 

