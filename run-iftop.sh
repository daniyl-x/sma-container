#!/bin/sh

while [ 1 ]; do
  iftop -t -s 11 -L 30 -n -P  | tee iftop-out.txt > /dev/null
  cat iftop-out.txt > iftop-result.txt
  sleep 1
done

