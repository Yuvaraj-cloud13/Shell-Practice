#!/bin/bash

USERID=$(id -u)

#check root access or not
if [ $USERID -ne 0 ]; then
    echo "Please run this script with root access"
    exit 1
fi

# First arg -> what are you tring to install
# second arg -> exit code
VALIDATE(){
    if [ $2 -ne 0 ]; then
        echo "installing $1 is ...failed"
        exit 1
    else 
        echo "installing $1 is ...success"
    fi

}

dnf list installed mysql

if [ $? -eq 0 ]; then
    echo "mysql already installed...skipping"
else    
    echo "installing mysql"
    dnf install mysql -y
    VALIDATE mysql $?
fi



dnf list installed nginx

if [ $? -eq 0 ]; then
    echo "nginx already installed...skipping"
else    
    echo "installing nginx"
    dnf install nginx -y
    VALIDATE nginx $?
fi