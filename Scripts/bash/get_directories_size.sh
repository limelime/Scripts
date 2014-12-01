# du --max-depth=3 -c -h > directories_size_`date +"%Y-%m-%d_%0k.%M.%S"`.txt
# 23mins: du --max-depth=1 -k | sort -nr | cut -f2 | xargs -d '\n' du -sh > directories_size_`date +"%Y-%m-%d_%0k.%M.%S"`.txt
# 4 mins: du --max-depth=1 -k * | sort -nr | awk '{ if($1>=1024*1024) {size=$1/1024/1024; unit="G"} else if($1>=1024) {size=$1/1024; unit="M"} else {size=$1; unit="K"}; if(size<10) format="%.1f%s"; else format="%.0f%s"; res=sprintf(format,size,unit); printf "%-8s %s\n",res,$2 }' > directories_size_`date +"%Y-%m-%d_%0k.%M.%S"`.txt

du --max-depth=4 --human-readable | sort -h -r > directories_size_`date +"%Y-%m-%d_%0k.%M.%S"`.txt