#!/usr/bin/expect --
# Input: username password
set USER [lindex $argv 0]
set PASS [lindex $argv 1] 

if { $USER == "" || $PASS == "" }  {
	   puts "Usage:  ./scriptname username password\n"
	      exit 1
	       }

	       spawn sudo passwd $USER 
	       expect "assword:"
	       send "$PASS\r"
	       expect "assword:"
	       send "$PASS\r"
	       expect eof