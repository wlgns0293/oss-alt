#!/bin/bash
grep 'srv6$' data/access.log | awk '{print $3}' | sort | uniq -c | sort -nr | head -n 5 > results/a03.txt

