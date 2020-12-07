#!/usr/bin/env bash 

while true  
do   
    procnum=` ps -ef|grep "Run"|grep -v grep|wc -l ` 
    if [[ $procnum -eq 1 ]]; then
    	./run.sh
    fi
    sleep 5
done  