#!/bin/bash

if [ "$MODE" == "Master" ]; then
  CFG=$MASTER_CONFIG
else
  CFG=$GITLAB_CONFIG
fi

haproxy -db -f $CFG
