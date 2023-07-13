! #/bin/bash

function walk_dir(){
	root=`pwd`
    for element in `ls "$*" | tr " " "\?"`
    do
        element=`tr "\?" " " <<<$element`
		date_str="${element:0:0-6}"
        dir_or_file="$root"/"$element"

        if [ -d "$dir_or_file" ];then
            # echo "$dir_or_file"
			echo $date_str
            cd "$dir_or_file"
			# rename 's/.*\.mobi/$date_str\.mobi/' *.mobi
			mv *mobi ../"$date_str.mobi"
			mv *pdf "$date_str.pdf"
			mv *epub "$date_str.epub"
			mv *azw3 ../"$date_str.azw3"
        fi
    done
}

target_dir=$1
target_host=$2

root_dir=`pwd`
walk_dir $root_dir
cd "${root_dir}"
find . -maxdepth 2 -type f -name "*.epub" -mtime -15 -print0 | xargs -0 -I{} scp -r {} "${target_host}:${target_dir}"
