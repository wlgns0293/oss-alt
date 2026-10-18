#!/bin/bash
awk '$8=="srv6" {sum += $7; count++} END {printf "%d\n%.2f\n", sum, sum/count}' data/access.log > results/a06.txt
