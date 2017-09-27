#!/usr/bin/env bash

osqueryi "SELECT DISTINCT processes.name, listening_ports.port, processes.pid FROM listening_ports JOIN processes USING (pid)   WHERE listening_ports.address = '0.0.0.0';"
