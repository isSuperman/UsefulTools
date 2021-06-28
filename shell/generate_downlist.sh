#!/bin/bash

#
# Copyright (c) 2019-2021 IsSuperman
# https://github.com/IsSuperman/UsefulTools
# File name: generate-downlist.sh
# Description: 格式化下载链接
#

for firm in vmdk vmdk_efi img img_efi rootfs rootfs_img
	do
		if test -f ${firm}_md.log; then
			sed -i ':a;N;$!ba;s/\n/  /g' ${firm}_md.log
			sed -i "s/^/\- ${firm^^}\\n&/g" ${firm}_md.log
			sed -i 's/_/-/g' ${firm}_md.log
			echo "$(cat ${firm}_md.log)" >> down_list.log
		fi
done

	sed -i 's/\-/\\-/g' down_list.log
	sed -i 's/\./\\./g' down_list.log
	sed -i 's/\_/\\_/g' down_list.log
