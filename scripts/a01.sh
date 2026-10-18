#!/bin/bash

wc -l < data/access.log > results/a01.txt 

grep 'srv6$' data/access.log | wc -l >> results/a01.txt 

grep 'srv6$' data/access.log | grep 'POST' | wc -l >> results/a01.txt
