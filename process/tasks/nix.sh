#!/usr/bin/env bash

if [[ $PT_name ]]; then
    processes=`ps -ef | grep "${PT_name}"`
    if [[ $processes ]]; then
        echo '{"_items": ['
        numlines=`echo "$processes" | wc -l`
        count=0
        echo "$processes" | while read line; do
            output="{ \"Name\": \"`echo $line | cut -d' ' -f8-`\", "
            output+=$(echo $line | awk '{split($0,a," "); print "\"CPU\": \"" a[7] "\", \"Id\":" a[2] "}"}')
            let count++
            if [[ $count -ne $numlines ]]; then
                output+=","
            fi
            echo "  $output"
        done
        echo ']}'
    fi
else
    ps -ef
fi

