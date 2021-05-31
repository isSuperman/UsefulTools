#!/bin/bash


#start_date=`date +%s -d "2011-11-28 13:50:37"`
#end_date=`date +%s -d "2011-11-28 15:55:52"`

spend=`expr $2 - $1`

if [[ $spend < 60 ]];then
	echo "$spend秒"
fi

if [[ $spend > 60 ]]&&[[ $spend < 3600 ]];then
	min=`expr $spend / 60`
	cha1=`expr $min \* 60`
	sec=`expr $spend - $cha1`
	echo "$min分$sec秒"
fi

if [[ $spend > 3600 ]];then
	hour=`expr $spend / 3600`
	hour_s=`expr $hour \* 3600`
	min0=`expr $spend - $hour_s`
	min=`expr $min0 / 60`
	min_s=`expr $min \* 60`
	sec0=`expr $spend - $hour_s`
	sec=`expr $sec0 - $min_s`
	echo "$hour小时$min分$sec秒"
fi
