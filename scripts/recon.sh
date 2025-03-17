#!/bin/bash

if [ "$(uname)" = 'Darwin' ]; then
    macos=1
fi
if [ "$(uname)" = 'Linux' ]; then
    linux=0
fi

echo --- User ---

me=$(whoami)
echo "User: $me"

echo --- Groups ---

split_groups(){
    original_ifs="$IFS"
    IFS=','
    read -ra groups <<< "$@"

    for group in "${groups[@]}"; do
        echo "$group"
    done

    IFS="$original_ifs"
}
split_groups $(id)

echo ---- System ----

if [ $mac ]; then
    sw_vers
fi
if [ $linux ]; then
    cat /etc/os-release
fi

echo $(uname -v)

echo ---- Ip ----

ifconfig | awk '/^[a-z]/ { iface=$1 } /inet / { print iface, $2 }'

echo ---- Servers ----

lsof -i -P -n | grep -e PID -e LISTEN

echo --- DNS ---

if [ $macos ]; then
    smac scutil --dns
fi
if [ $linux ]; then
    echo "/etc/resolv.conf"
    cat /etc/resolv.conf
    echo "/etc/hosts"
    cat /etc/hosts | grep -v '^#'
fi

echo ---- Commands ----

check_cmd(){
    for cmd_name in "$@"; do
        if command -v "$cmd_name" &> /dev/null; then
            echo "$cmd_name""✓"
        else
            echo "$cmd_name"
        fi
    done
}

commands=(
    "curl"
    "docker"
    "ftp"
    "gcc"
    "git"
    "java"
    "make"
    "nc"
    "nmap"
    "node"
    "npm"
    "perl"
    "pip"
    "python"
    "python3"
    "ruby"
    "ssh"
    "tcpdump"
    "wget"
    "powershell"
    "dotnet"
)

check_cmd "${commands[@]}"
