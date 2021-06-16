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
now_year=$(date +"%Y")
recent_date=""


if [[ "$#" < 2 ]]
then
  echo "给定参数缺失"
  exit 1
fi

if [[ "$3" == "" ]]
then
	echo "未提供日期参数，默认获取最新commit信息"
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
grep -Po '(?<="date": ").*?(?=T)' str_commit.log > date_commit_list.log

while read line
do
	recent_date="$line"
	echo "$recent_date" > recent_date.log
	break
done < "./date_commit_list.log"

while read line
do	
	result=$(echo $line | grep "$recent_date")
	
	if [[ "$result" != "" ]]
	then 
		echo $line >> day.log
	else
		break
	fi
	
done < "./str_commit.log"

grep -Po '(?<="message": ").*?(?=")' day.log > day2.log
sed -i 's#).*$#)#g' day2.log

dayy=0

while read line
do
	dayy=$(($dayy+1))
	if [[ "$dayy" == 1 ]]
	then
		echo "\-${dayy}\- ${line}" >> day3.log
	else
		echo "\n\-${dayy}\- ${line}" >> day3.log
	fi
done < "./day2.log"
# 去掉回车换行
sed -i ':a;N;$!ba;s/\n//g' day3.log

# 防止转义-

sed -i "s/${now_year}-//g" recent_date.log
sed -i 's/\-/\\./g' recent_date.log

sed -i 's/\-/\\-/g' day3.log
sed -i 's/\./\\./g' day3.log		
sed -i 's/(/\\(/g' day3.log
sed -i 's/)/\\)/g' day3.log
sed -i 's/\#/\\#/g' day3.log
sed -i 's/<[^>]*>//g' day3.log
sed -i 's#>=#\\>\\=#g' day3.log
sed -i 's#<=#\\<\\=#g' day3.log
#sed -i 's/\*\+//g' day3.log
sed -i 's#\\([^)]*)##g' day3.log
sed -i 's/\_/\\-/g' day3.log	
sed -i 's/\'//g' day3.log
