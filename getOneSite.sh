#!/bin/bash
set -x
./das.py --limit=1000 --format=plain --query="site dataset=$1 | grep site.name,site.replica_fraction" | tail -n +4 | sort | tr '\n' ' ' | tr '%' '\n' | tr ']' '\n' | tee sites/$(echo $1 | md5sum | awk '{print $1}')
