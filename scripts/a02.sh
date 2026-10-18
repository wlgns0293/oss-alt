#!/bin/bash
grep 'srv6$' data/access.log | awk '{print $6}' | sort | uniq -c > results/a02.txt
