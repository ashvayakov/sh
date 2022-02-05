#!/usr/bin/expect -f

if {$argc!=2} {
send_user "usage: $argv0 username password \n"
exit
}

# script must be run by root user
set whoami [exec id -u]
if {$whoami!=0} {
send_user "You must be a root user to run this script\n"
exit
}

set timeout -1
match_max 100000

# stopre password
set password [lindex $argv 1]

# username
set user [lindex $argv 0]

# opem shell
spawn $env(SHELL)

# send passwd command
send -- "LC_ALL=C passwd $user\r"
expect "assword:"
send "$password\r"
expect "assword:"
send "$password\r"
send "\r"
expect eof


