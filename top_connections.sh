#!/bin/bash

netstat -ntu | grep -v "Addr\|serv" | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr
