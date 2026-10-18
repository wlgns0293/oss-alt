#!/bin/bash
awk -F, 'NR>1 && $3=="B" {count++} END {print count}' data/scores.csv > results/a08.txt
awk -F, 'NR>1 && $3=="B" {sum+=$4; count++} END {printf "%.2f\n", sum/count}' data/scores.csv >> results/a08.txt
grep ',B,' data/scores.csv | sort -t, -k4,4nr | head -n 1 | awk -F, '{print $2, $4}' >> results/a08.txt
