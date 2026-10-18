#!/bin/bash
awk '$8=="srv6" && $6==500' data/access.log > results/srv6_500.log
cat results/srv6_500.log | wc -l > results/a05.txt
tail -n 3 results/srv6_500.log >> results/a05.txt
