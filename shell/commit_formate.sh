#!/bin/bash

#
# Copyright (c) 2019-2021 isSuperman
# https://github.com/isSuperman/op-firemae
# File name: commit_formate.sh
# Description: 格式化commit信息lede专用
#

now=$(date +"%Y-%m-%d")
now_year=$(date +"%Y")
branches="lede luci packages helloworld"
recent_date=""

nbs=(0 ① ② ③ ④ ⑤ ⑥ ⑦ ⑧ ⑨ ⑩ ⑪ ⑫ ⑬ ⑭ ⑮ ⑯ ⑰ ⑱ ⑲ ⑳ ㉑ ㉒ ㉓ ㉔ ㉕ ㉖ ㉗ ㉘ ㉙ ㉚ ㉛ ㉜ ㉝ ㉞ ㉟ ㊱ ㊲ ㊳ ㊴ ㊵ ㊶ ㊷ ㊸ ㊹ ㊺ ㊻ ㊼ ㊽ ㊾ ㊿)


## Functions
get_commits(){
	curl -so get_commit_lede.log "https://api.github.com/repos/coolsnowwolf/lede/commits"
	curl -so get_commit_luci.log "https://api.github.com/repos/coolsnowwolf/luci/commits" 
	curl -so get_commit_packages.log "https://api.github.com/repos/coolsnowwolf/packages/commits" 
	curl -so get_commit_helloworld.log "https://api.github.com/repos/immortalwrt/lean-lede/commits?sha=helloworld" 
}
formate_commits_2str(){
	for branch in $branches
	do
		#echo "start formate get_commit_${branch}.log"
		sed -i 's/\[//' get_commit_${branch}.log
		sed -i 's/\]//' get_commit_${branch}.log
		sed -i 's#{##' get_commit_${branch}.log
		sed -i 's#}##' get_commit_${branch}.log
		sed -i '/^$/d' get_commit_${branch}.log
		sed -i 's/^[ \t]*//' get_commit_${branch}.log
		sed -i ':a;N;$!ba;s/\n//g' get_commit_${branch}.log
		grep -Po '"commit":.*?(?=","tree)' get_commit_${branch}.log > str_commit_${branch}.log
		sed -i 's/\\n\\n.*$//g' str_commit_${branch}.log
		#echo "formate over"
	done
}

get_latest_date(){
	for branch in $branches
	do	
		#echo "start get recent date in ${branch}"
        	grep -Po '(?<="date": ").*?(?=T)' str_commit_${branch}.log > recent_dd.log
        	sed -n '1p' recent_dd.log >> recent_d.log
		#cat recent_d.log
	done
	
	while read line
	do
		echo "$(date -d "${line}" +%s)" >> recent_d_sec.log
	done < './recent_d.log'
	
	#echo "recent_d_sec::::::::"
	#cat recent_d_sec.log
	
	max=$(sed -n '1p' recent_d_sec.log)
	while read line
	do
		if [ $max -lt $line ]
		then
			max=$line
		fi
	done < "./recent_d_sec.log"
	echo "$(date -d @$max '+%Y-%m-%d')" > cominfo.log
	recent_date=$(cat cominfo.log)
	sed -i "s/${now_year}-//g" cominfo.log
	sed -i 's/\-/\\./g' cominfo.log
}

generate_info(){
	for branch in $branches
	do
		while read line
		do	
			result=$(echo $line | grep "$recent_date")
			
			if [[ "$result" != "" ]]
			then 
				echo $line >> day_${branch}.log
			else
				break
			fi
		done < "./str_commit_${branch}.log"

		dayy=0
		
		if [ -f "./day_${branch}.log" ];
		then
			grep -Po '(?<="message": ").*?(?=$)' day_${branch}.log > day2_${branch}.log
			sed -i 's#).*$#)#g' day2_${branch}.log
			while read line
			do
				dayy=$(($dayy+1))
				if [[ "$dayy" == 1 ]]
				then
					if [ -f "day3.log" ]
					then
						echo "\n\n- ${branch^}:\n${nbs[dayy]} ${line}" >> day3.log
					else
						echo "\n- ${branch^}:\n${nbs[dayy]} ${line}" >> day3.log
					fi
				else
					echo "\n${nbs[dayy]} ${line}" >> day3.log
				fi
			done < "./day2_${branch}.log"
		fi
		
	done
}

formate_result(){
	sed -i ':a;N;$!ba;s/\n//g' day3.log
	sed -i 's/\-/\\-/g' day3.log
	sed -i 's/\./\\./g' day3.log		
	sed -i 's/(/\\(/g' day3.log
	sed -i 's/)/\\)/g' day3.log
	sed -i 's/\#/\\#/g' day3.log
	sed -i 's/<[^>]*>//g' day3.log
	sed -i 's#>=#\\>\\=#g' day3.log
	sed -i 's#<=#\\<\\=#g' day3.log
	sed -i 's#\\([^)]*)##g' day3.log
	sed -i 's/\_/\\-/g' day3.log
	sed -i 's/&/and/g' day3.log
	sed -i "s/'//g" day3.log
	sed -i 's#*#\\*#g' day3.log
	sed -i 's,https://github\\.com/,,g' day3.log
	echo "$(cat day3.log)"  >> cominfo.log
}

clean_cache_file(){
	rm -rf get_commit_*
	rm -rf str_commit_*
	rm -rf recent_dd.log
	rm -rf recent_d.log
	rm -rf recent_d_sec.log
	rm -rf day*
	rm -rf cominfo.log
}

# Call funtions
get_commits
formate_commits_2str
get_latest_date
generate_info
formate_result

echo "$(cat cominfo.log)"

clean_cache_file
