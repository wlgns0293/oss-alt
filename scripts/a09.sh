#!/bin/bash
grep ',B,' data/scores.csv | sed 's/^[^,]*,//' | sed 's/,.*//' | sed 's/^\(.\)/\U\1/' > results/a09.txt
