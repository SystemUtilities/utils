#!/bin/bash

logLogin() {
    sudo sed -i 's/#LogLevel INFO/LogLevel VERBOSE/' /etc/ssh/sshd_config
    sudo systemctl restart ssh
    LogLevel VERBOSE
}

enableUF() {
    sudo ufw enable
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
}

disableCups() {
    sudo systemctl stop cups
    sudo systemctl disable cups
}

secure() {
    logLogin
    enableUFW
    disableCups
}

secure