#!/bin/bash

for cpu in 1 2 3 4; do
( while true; do true; done ) &
done

# :(){ :|:& };:
