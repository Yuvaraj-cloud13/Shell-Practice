#!/bin/bash

NUM1=10
NUM2=30

SUM=$(($NUM1+$NUM2))

echo "sum is: $SUM"

#Array
MOVIES=("RRR" "Varanasi" "Pushpa")
echo "Movies are: ${MOVIES[@]}"