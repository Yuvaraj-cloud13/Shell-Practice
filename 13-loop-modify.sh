#!/bin/bash

USERID=$(id -u)
#LOGS_DIR=/var/log/shell-script
#LOG_FILE="$LOGS_DIR/$0.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

#check root access or not
if [ $USERID -ne 0 ]; then
    echo "Please run this script with root access"
    exit 1
fi

# First arg -> what are you tring to install
# second arg -> exit code
VALIDATE(){
    if [ $2 -ne 0 ]; then
        echo "$TIMESTAMP [ERROR] installing $1 is ...failed" | tee -a $LOG_FILE
        exit 1
    else 
        echo "$TIMESTAMP [INFO] installing $1 is ...success" | tee -a $LOG_FILE
    fi

}


for package in $@
do
    echo "$TIMESTAMP [INFO] installing $package"
    dnf list installed $package &>> $LOG_FILE
    if [ $? -eq 0 ]; then
        dnf install $package -y &>> $LOG_FILE
        VALIDATE "installing $package" $?
    else
        echo "$TIMESTAMP [INFO] $package already installed...skipping"
    fi
done
