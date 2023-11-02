#!/bin/bash

if [ $# -ne 0 ]; then
  curl https://brubeckscan.app/api/nodes/${1} | jq .
else
  echo "need a key"
fi
