#!/usr/bin/env bash

wl=3
cs='BCDFGHJKLMNPQRSTVWXZY'
vs='AEIOU'
result=''

for ((i=0; i<wl; i++)); do
    result+="${cs:$((RANDOM % ${#cs})):1}${vs:$((RANDOM % ${#vs})):1}"
done

echo "$result"
