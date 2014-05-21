#!/bin/bash
set -x
./das.py --limit=1000 --format=plain --query="dataset dataset=$1 | grep dataset.size" | tail -n 1 | tee sizes/$(echo $1 | md5sum | awk '{print $1}')
