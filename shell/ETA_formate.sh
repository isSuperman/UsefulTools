#!/bin/bash

#
# Copyright (c) 2019-2021 isSuperman
# https://github.com/isSuperman/UsefulTools
# File name: ETA_formate.sh
# Description: 人性化预期时间格式化
# $1 目标时间的日期day号
# $2 目标时间的小时
#

now_day=$(date "+%d")
dd=""
dd2=""


if [[ $1 == $now_day ]]
then
	dd="今天"
else
	dd="明天"
fi

case $2 in
[0-6])
	dd2="凌晨"
	;;
[7-9])
	dd2="上午"
	;;
[1][0-1])
	dd2="上午"
	;;
[1][2-4])
	dd2="中午"
	;;
[1][5-8])
	dd2="下午"
	;;
[1][9])
	dd2="傍晚"
	;;
[2][0-2])
	dd2="晚上"
	;;
[2][3])
	dd2="深夜"
	;;
*)
	echo "There went some wrong"
esac

echo "${dd}${dd2}"
