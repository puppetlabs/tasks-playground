#!/usr/bin/env bash

osqueryi "SELECT pid,name,cmdline FROM processes"
