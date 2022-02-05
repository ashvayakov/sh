#!/bin/bash
 
# The first argument is Domain ID, use 0 by default
domID=${1:-0}
 
ssh -p22 sadmin10.2.1.90 <<EOF
# Print RAW capacity for selected disk domain
show disk_domain general |filterRow column=ID predict=equal_to value=$domID |filterColumn include columnList=Free\sCapacity
 
# Print Available capacity for selected disk domain
show disk_domain available_capacity disk_domain_id=$domID raid_level=RAID5-8|filterColumn include columnList=Tier2\sAvailable\sCapacity
EOF

