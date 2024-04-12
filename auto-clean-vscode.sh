#!/bin/bash

# 检查内存占用情况
MEMORY=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

# 判断内存占用是否超过设定的阈值，这里设定为90%
if [ $(echo "$MEMORY > 90" | bc) -eq 1 ]; then
    echo "Memory usage is over 90%!" >> /tmp/memory-usage.log
    ps uxa | grep .vscode-server | awk '{print $2}' | xargs kill -9
    echo "Killed vscode-server" >> /tmp/memory-usage.log
    MEMORY=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    echo "Memory usage after killing vscode-server: $MEMORY%" >> /tmp/memory-usage.log
fi
