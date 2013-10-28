if [ $# -ne 1 ]
then 
        echo "Usage: $0 <directory>" >&2
        exit 1
fi

if [ -d "$1" ]; 
then
	echo
else
	echo "Please enter a valid directory"
	exit 1
fi

directory=$1

echo
echo "Generating MD5Hash"
echo "******************"
x=0
for file in `find $directory -type f`; do
        files[x]=`md5sum $file`
	echo "${files[x]}"
	((x++))
done
echo -e "\n"
echo "Checking for duplicate files inside $directory"
echo "********************************************************"
echo

y=0
for i in "${files[@]}"; do
	z=0
	c=0
	file=($i)
	filePath=${file[1]}
	fileHashI=${file[0]}
	totalSize=0
	for j in "${files[@]}"; do
		fileJ=($j)
		filePathJ=${fileJ[1]}
		fileHashJ=${fileJ[0]}
		if [ "$fileHashI" == "$fileHashJ" ];
		then
			size=(`stat -c %s $filePathJ`)
			totalSize=$(($size + $totalSize))
			if [ $size -lt 1000 ];
				then
					match[$c]="$fileHashJ $size B $filePathJ \n"
			fi
			if [ $size -ge 1000 ];
                                then
					humanSize=$(($size/1000))
                                        match[$c]="$fileHashJ $humanSize K $filePathJ \n"
                        fi
			if [ $size -ge 1000000 ];
                                then
                                        humanSize=$(($size/1000000))
                                        match[$c]="$fileHashJ $humanSize M $filePathJ \n"
                        fi
			if [ $size -ge 1000000000 ];
                                then
                                        humanSize=$(($size/1000000000))
                                        match[$c]="$fileHashJ $humanSize K $filePathJ \n"
                        fi
			((c++))
		fi
	done
	if [ $c -gt 1 ];
	then
                if [ $totalSize -lt 1000 ];
                then
                        echo "$filePath has $c occurences ( $(($c-1)) duplicates ) that take $totalSize B"
                fi
		if [ $totalSize -ge 1000 ];
                then
            		humanTotalSize=$(($totalSize/1000))
			echo "$filePath has $c occurences ( $(($c-1)) duplicates ) that take $humanTotalSize K"
            	fi
		if [ $totalSize -ge 1000000 ];
                then
                        humanTotalSize=$(($totalSize/1000000))
			echo "$filePath has $c occurences ( $(($c-1)) duplicates ) that take $humanTotalSize M"
                fi
		if [ $totalSize -ge 1000000000 ];
                then
                        humanTotalSize=$(($totalSize/1000000000))
                        echo "$filePath has $c occurences ( $(($c-1)) duplicates ) that take $humanTotalSize G"
                fi
		
		echo -e " ${match[@]} \n"
		unset match
		totalSize=0
	fi
done
