#!/bin/bash

# -------------------------------------------------------------------------------------------------
# Pi-PwnBox-RogueAP 
# https://github.com/koutto/pi-pwnbox-rogueap
# -------------------------------------------------------------------------------------------------
# Start Guacamole service
# -------------------------------------------------------------------------------------------------


RED=`tput setaf 1`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`
YELLOW=`tput setaf 3`
RESET=`tput sgr0`


if [[ $EUID -ne 0 ]]; then
   echo "${RED}[!] This script must be run as root ${RESET}"
   exit 1
fi

# Auto-detect Tomcat version (tomcat9, tomcat10, etc.)
TOMCAT_SVC=$(systemctl list-unit-files --type=service 2>/dev/null | grep -oE '^tomcat[0-9]*\.service' | head -n1 | sed 's/\.service//')
[ -z "$TOMCAT_SVC" ] && TOMCAT_SVC="tomcat9"

systemctl start guacd
systemctl start ${TOMCAT_SVC}
systemctl start mysql

echo "${GREEN}[+] Guacamole started. Access via http://<ip>:8080/guacamole/${RESET}"
echo

#systemctl status guacd
#systemctl status ${TOMCAT_SVC}
#systemctl status mysql
