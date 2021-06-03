#!/bin/bash

#
# Copyright (c) 2019-2021 IsSuperman
# https://github.com/IsSuperman/op-firemae
# File name: commit_formate.sh
# Description: 格式化commit信息
# $1 仓库所有者名字
# $2仓库名字
# $3 commit日期 默认当前日期 格式 2021-01-01
#

now=$(date +"%Y-%m-%d")
num=0


if [[ "$#" < 2 ]]
then
  echo "给定参数缺失"
  exit 1
fi

if [[ "$3" != "" ]]
then
  now=$3
else
	echo "未提供日期参数，默认使用当天日期"
fi

# 获取所有Commit信息保存到 get_commit.log
curl -so get_commit.log "https://api.github.com/repos/$1/$2/commits" 

sed -i 's/\[//' get_commit.log
sed -i 's/\]//' get_commit.log
sed -i 's#{##' get_commit.log
sed -i 's#}##' get_commit.log
sed -i '/^$/d' get_commit.log
sed -i 's/^[ \t]*//' get_commit.log
sed -i ':a;N;$!ba;s/\n//g' get_commit.log

grep -Po '"commit":.*?(?=tree)' get_commit.log > str_commit.log

while read line
do	
	result=$(echo $line | grep "$now")
	if [[ "$result" != "" ]]
	then 
		echo $line >> day.log
		num=$(($num+1))	
	else
		break
	fi
	
done < "./str_commit.log"
if [[ "$num" != 0 ]]
then 
	grep -Po '(?<="message": ").*?(?=")' day.log > day2.log
	sed -i 's#).*$#)#g' day2.log

	dayy=1

	while read line
	do
		if [[ "$dayy" == 1 ]]
		then
			dayy=$(($dayy+1))
			echo "- ${line}" >> day3.log
		else
			echo "\n- ${line}" >> day3.log
		fi
	done < "./day2.log"
	# 去掉回车换行
	sed -i ':a;N;$!ba;s/\n//g' day3.log

	# 防止转义-
	sed -i 's/\-/\\\-/g' day3.log
	sed -i 's/\./\\\./g' day3.log
	sed -i 's/(/\\(/g' day3.log
	sed -i 's/)/\\)/g' day3.log
	sed -i 's/\#/\\#/g' day3.log
	sed -i 's/<[^>]*>//g' day3.log
	sed -i 's/\*\+//g' day3.log
	sed -i 's#\\([^)]*)##g' day3.log
	sed -i 's/\_/\\\-/g' day3.log
else
	echo "- Nothing...." >> day3.log
	sed -i 's/\./\\\./g' day3.log
	sed -i 's/\-/\\\-/g' day3.log
fi
