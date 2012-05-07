#!/bin/bash

time dd if=/dev/zero of=/mnt/test/test.file bs=4M count=1000 conv=notrunc
time dd if=/dev/zero of=/mnt/test/test.file bs=4M count=1000 conv=notrunc oflag=direct
