#!/bin/bash
grep 'srv6$' data/access.log | head -n 10 | sed 's/srv6/SERVER-6/g' | sed 's/ GET / get /g' > results/a07.txt
