#!/usr/bin/env bash

set -eux


  
dd if=/dev/zero of=/EMPTY bs=1M || echo "dd exit code $? is suppressed";
rm -f /EMPTY;

sleep 10
sync;
sync;
sync;