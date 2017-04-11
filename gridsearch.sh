#!/bin/bash
LRs=( 00005 0001 0002)
BSs=( 32 80 )

ID=0
IPs=( $(cut ip_and_port.txt -d ':' -f 1) )
PORTs=( $(cut ip_and_port.txt -d ':' -f 2) )

for LR in "${LRs[@]}" 
do
    for BS in "${BSs[@]}" 
    do 
    IP=${IPs[$ID]}
	PORT=${PORTs[$ID]}
	((ID++))
	SCRIPT="cd /mt/amunmt/; 
		git pull origin gridsearch;
		cd examples/training;
		rm config.txt;
		echo 'GPU 0' >> config.txt;
		echo 'LR 0.$LR' >> config.txt;
		echo 'BS $BS' >> config.txt;
		nohup ./run-me.sh > /dev/null 2>&1 &
		"
		
	ssh -o StrictHostKeyChecking=no -p $PORT heafield@$IP "${SCRIPT}"
    done
done

