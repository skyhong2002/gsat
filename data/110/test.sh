#!/bin/bash

path="www.cac.edu.tw/apply110/system/110_aColQry4qy_forapply_o5wp6ju"

rm new-apply

for id in `ls $path/html`; do
	file="$path/html/$id"
	id=${id/110_/}
	id=${id/.htm/}

	echo -ne "$id " |tee -a new-apply

	for s in "國文" "英文" "數學" "社會" "自然"; do
		mark=`grep -a -A3 "  <font size=\"2\"><b>$s</b></font>" $file |tail -n1 |grep -oP '>\K[^<]*(?=標<)'`
		if [ $? -ne 0 ]; then
			mark="無"
		fi
		echo -n $mark |tee -a new-apply
	done

done

echo "Done!"
wc new-apply

echo "Please confirm and move new-apply to apply"
