#!/bin/bash

#
# Copyright (c) 2019-2021 isSuperman
# https://github.com/isSuperman/UsefulTools
# File name: spend_time_formate.sh
# Description: 计算时间差并格式化为中/英文 xx小时xx分xx秒
# $1 起始时间 $(date +%s)
# $2 结束时间 同上
#

#start_date=`date +%s -d "2011-11-28 13:50:37"`
#end_date=`date +%s -d "2011-11-28 15:55:52"`

amin=60
ahour=3600

spend=`expr $2 - $1`

if [ $spend -lt $amin ]
then
	echo "${spend}s"
fi

if [ $spend -gt $amin -a $spend -lt $ahour ]
then
	min=`expr $spend / $amin`
	cha1=`expr $min \* $amin`
	sec=`expr $spend - $cha1`
	echo "${min}m ${sec}s"
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
	echo "${hour}h ${min}m ${sec}s"
fi
