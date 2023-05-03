#!/bin/bash

#####################################################
### Written by t0t0r <victormarechal59@gmail.com> ###
#####################################################

## CHECK IF NMAP IS ACTUALLY INSTALLED
command -v nmap >/dev/null 2>&1 || { echo >&2 "/!\ Nmap is required to run this script but it's not installed. Aborting."; exit 1; }

## BANNER SECTION
cat << EOF

██████╗ ██╗███████╗ ██████╗ ██████╗ ██╗   ██╗███████╗██████╗ ██╗   ██╗███████╗██╗  ██╗
██╔══██╗██║██╔════╝██╔════╝██╔═══██╗██║   ██║██╔════╝██╔══██╗╚██╗ ██╔╝██╔════╝██║  ██║
██║  ██║██║███████╗██║     ██║   ██║██║   ██║█████╗  ██████╔╝ ╚████╔╝ ███████╗███████║
██║  ██║██║╚════██║██║     ██║   ██║╚██╗ ██╔╝██╔══╝  ██╔══██╗  ╚██╔╝  ╚════██║██╔══██║
██████╔╝██║███████║╚██████╗╚██████╔╝ ╚████╔╝ ███████╗██║  ██║   ██║██╗███████║██║  ██║
╚═════╝ ╚═╝╚══════╝ ╚═════╝ ╚═════╝   ╚═══╝  ╚══════╝╚═╝  ╚═╝   ╚═╝╚═╝╚══════╝╚═╝  ╚═╝
                                                                                      
EOF

## GET ALL UP INTERFACE
IFACES=$(ip -br -4 addr show | grep UP | awk '{print $1}')
# USER PROMPT
echo "Which interface do you want to use?" 
select INTERFACE in ${IFACES[@]};do
# GET INTERFACE IP ADDRESS AND CRAFT BROADCAST ADDR
IP=$(ip -br -4 addr show | grep $INTERFACE | awk '{print $3}')
MASK=$(awk -F"/" '{print $2}'<<<$IP)
BROADCAST=${IP%.*}.0/$MASK
break
done
nmap -F -vv -oS result.txt $BROADCAST 
echo "Your report is ready at $(pwd)/result.txt"
