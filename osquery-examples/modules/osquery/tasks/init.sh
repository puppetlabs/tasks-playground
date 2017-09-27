#!/usr/bin/env bash

if [ -z "$PT_query" ]; then
  echo "Need to pass a query to run in the query argument"
  exit 1
fi

osqueryi "${PT_query}"
