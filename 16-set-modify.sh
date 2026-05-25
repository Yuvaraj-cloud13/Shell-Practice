#!/bin/bash

set -e
USERID=$(id -u)
#LOGS_DIR=/var/log/shell-script
#LOG_FILE="$LOGS_DIR/$0.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

trap 'echo "error at $LINENO", command: $BASH_COMMAND"' ERR

#check root access or not
if [ $USERID -ne 0 ]; then
    echo "Please run this script with root access"
    exit 1
fi


for package in $@
do
    echo "$TIMESTAMP [INFO] installing $package"
    dnf list installed $package &>> $LOG_FILE
    if [ $? -eq 0 ]; then
        dnf install $package -y &>> $LOG_FILE
    else
        echo -e "$TIMESTAMP [INFO] $package already installed... $Y skipping $N"
    fi
done