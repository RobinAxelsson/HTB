#!/bin/bash

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

# needs password
# sudo_output=$(sudo -n -l | tail -n 1)
# echo "$me may run: $sudo_output"

echo ---- System ----
if [ "$(uname)" = 'Darwin' ]; then
    sw_vers
fi
if [ "$(uname)" = 'Linux' ]; then
    cat /etc/os-release
fi

echo $(uname -v)

echo ---- Ip ----
ifconfig | awk '/^[a-z]/ { iface=$1 } /inet / { print iface, $2 }'
echo ---- Services ----
lsof -i -P -n | grep -e PID -e LISTEN
echo ---- Commands ----

check_cmd(){
    for command in "$@"; do
        if command -v $1 &> /dev/null; then
            echo "$command""✓"
        else
            echo "$command X"
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
)
check_cmd "${commands[@]}"
