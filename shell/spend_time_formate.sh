#!/bin/bash

#
# Copyright (c) 2019-2021 isSuperman
# https://github.com/isSuperman/UsefulTools
# File name: spend_time_formate.sh
# Description: 计算时间差并格式化为中/英文 xx小时xx分xx秒
# $1 起始时间 $(date +%s)
# $2 结束时间 同上
# $3 语言 'zh'/'en'
#

#start_date=`date +%s -d "2011-11-28 13:50:37"`
#end_date=`date +%s -d "2011-11-28 15:55:52"`

amin=60
ahour=3600

spend=`expr $2 - $1`

if [ $spend -lt $amin ]
then
	if [ "$3" -ne "zh" -a "$3" -ne "" ]
	then
		echo "${spend}s"
	else
		echo "${spend}秒"
	fi
fi

if [ $spend -gt $amin -a $spend -lt $ahour ]
then
	min=`expr $spend / $amin`
	cha1=`expr $min \* $amin`
	sec=`expr $spend - $cha1`
	if [ "$3" -ne "zh" -a "$3" -ne "" ]
	then
		echo "${min}m ${sec}s"
	else
		echo "${min}分${sec}秒"	
	fi
	
fi

if [ $spend -gt $ahour ]
then
	hour=`expr $spend / $ahour`
	hour_s=`expr $hour \* $ahour`
	min0=`expr $spend - $hour_s`
	min=`expr $min0 / $amin`
	min_s=`expr $min \* $amin`
	sec0=`expr $spend - $hour_s`
	sec=`expr $sec0 - $min_s`
	if [ "$3" -ne "zh" -a "$3" -ne "" ]
	then
		echo "${hour}h ${min}m ${sec}s"
	else
		echo "${hour}小时${min}分${sec}秒"	
	fi
fi
