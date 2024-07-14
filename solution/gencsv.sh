#!/bin/bash

n=$2
i=$1
while ((i<=n)); do
    echo "$((i++)), $RANDOM"
done > inputFile
