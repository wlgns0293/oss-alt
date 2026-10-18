#!/bin/bash
grep -c ',MIT' data/licenses.csv > results/a12.txt
grep ',GPL,' data/licenses.csv | sort -t, -k3,3nr | head -n 3 >> results/a12.txt
