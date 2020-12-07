#!/bin/bash  
  
while true  
do   
    procnum=` ps -ef|grep "Run"|grep -v grep|wc -l ` 
    if [[ $procnum -eq 1 ]]; then
         echo "AutoReboot"
        /Users/kimi/Desktop/AutoReboot/App/Run &  
    fi
    sleep 30
done  