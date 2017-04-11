#!/bin/bash

IPs=( $(cut ip_and_port.txt -d ':' -f 1) )
PORTs=( $(cut ip_and_port.txt -d ':' -f 2) )

SCRIPT="kill \$(nvidia-smi | awk '\$2==\"Processes:\" {p=1} p && \$3 ~ /^[0-9]+\$/ {print \$3}')"


for (( ID=0;ID<${#IPs[@]};ID++ ))
do
	IP=${IPs[$ID]}
	PORT=${PORTs[$ID]}
	echo "checking: $IP $PORT"
	ssh -o StrictHostKeyChecking=no -p $PORT -l heafield $IP "${SCRIPT}"
done



