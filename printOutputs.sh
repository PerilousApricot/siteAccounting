#!/bin/bash
(
#set -x
while read LINE; do
    DATASET_HASH=$(echo $LINE | md5sum | awk '{print $1}')
    if [[ -e sizes/$DATASET_HASH && $(grep -v "record" sizes/$DATASET_HASH)  ]]; then
        BYTE_SIZE=$(cat sizes/$DATASET_HASH)
        if [[ -e sites/$DATASET_HASH && $(grep -v "record" sites/$DATASET_HASH) ]]; then
            SITE_PERCENTAGE=$(cat sites/$DATASET_HASH | grep T2_US_Vanderbilt | awk '{print $2 }')
            SITE_SIZE=$(echo "$BYTE_SIZE * $SITE_PERCENTAGE / 100" | bc)
            HUMAN_SIZE=$(numfmt --to=iec-i --suffix=B --format="%3f" ${SITE_SIZE})
            echo "$SITE_SIZE $HUMAN_SIZE $LINE $(cat sites/$DATASET_HASH | awk '{print $1}' | tr '\n' ' ')"
        else
            HUMAN_SIZE=$(numfmt --to=iec-i --suffix=B --format="%3f" ${BYTE_SIZE})
            echo "$BYTE_SIZE $HUMAN_SIZE $LINE UNKNOWN"
        fi
    else
        echo "0 0B $LINE UNKNOWN"
    fi
done < allDatasets-sorted.txt ) | sort -n -r | awk '{ $1=""; print}' | sed 's/^ //'
