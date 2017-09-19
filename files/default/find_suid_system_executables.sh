#!/bin/bash

# Find SUID System Executables

df --local -P | awk {'if (NR!=1) print $6'} | uniq | xargs -I '{}' find '{}' -xdev -type f -perm -4000 -print
