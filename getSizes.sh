#!/bin/bash

(while read LINE; do
    SIZEHASH=$(echo $LINE | md5sum | awk '{print $1}')
    if [[ -z $(grep '$\d*^' sizes/$SIZEHASH 2>/dev/null) ]]; then
        echo $LINE
    fi
done < allDatasets-sorted.txt) | xargs -n 1 -P 8 ./getOneSize.sh
