#!/bin/bash
(while read LINE; do
    SITEHASH=$(echo $LINE | md5sum | awk '{print $1}')
    if [[ -z $(grep 'T2_US_Vanderbilt' sites/$SITEHASH 2>/dev/null) ]]; then
        echo $LINE
    fi
done < allDatasets-sorted.txt) | xargs -n 1 -P 8 ./getOneSite.sh

