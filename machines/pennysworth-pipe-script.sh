#!/bin/bash
echo ------- Os/System ---------
echo cat /etc/os-release
cat /etc/os-release
echo uptime
uptime

echo ---- Network -------
echo ss -lt
ss -lt #-tuln for udp
echo ss -ltn
ss -ltn
echo ip -brief addr show
ip -brief addr show

echo ------ Processes ------
echo ps aux
ps aux #check running processes
#echo lsof # too verbose, dont know what to check for
#lsof #open files or network connections 
echo uname -r
uname -r #kernel version

echo ----- Commands ------

commands=(
    "python"
    "python3"
    "node"
    "ssh"
    "curl"
    "wget"
    "gcc"
    "make"
    "git"
    "perl"
    "ruby"
    "pip"
    "npm"
    "docker"
    "tcpdump"
    "nmap"
    "nc"
    "ftp"
    "java"
)


# Loop through the list and check if each command is available
for cmd in "${commands[@]}"; do
    if command $cmd > /dev/null 2>&1; then
        echo "$cmd is available"
    else
        echo "$cmd is NOT available"
    fi
done

# echo ---
# echo secret.key:
# cat /var/lib/jenkins/secret.key
# echo ---
# echo not-so-secret:
# cat /var/lib/jenkins/secret.key.not-so-secret
# echo ---
# echo secrets
# echo master key:
# cat /var/lib/jenkins/secrets/master.key
# echo hudson.util.Secret:
# cat /var/lib/jenkins/secrets/hudson.util.Secret
# echo "ls -la"
# echo "--secrets dir"
# ls -la /var/lib/jenkins/secrets

# echo xxxxxxxxxxxxxxxxxxx
# pwd
# ls -la
# cd ..
# echo ----------------------------
# pwd
# ls -la
# cd ..
# echo ----------------------------
# pwd
# ls -la
# cd ..
# echo ----------------------------
# pwd
# ls -la
# cd ..
# echo ----------------------------
# pwd
# ls -la
# cd ..
# echo ----------------------------
# pwd
# ls -la
# cd ..
# echo ----------------------------
# pwd
# ls -la
# cd ..
# echo ----------------------------
# pwd
# ls -la
# cd ..
# echo ----------------------------
# pwd
# ls -la
# cd ..
# echo ----------------------------
