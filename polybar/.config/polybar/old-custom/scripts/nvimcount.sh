#!/bin/bash
count=$(pgrep -xc nvim)
if [ "$count" -gt 0 ]; then
    echo " $count"
else
    echo ""
fi

