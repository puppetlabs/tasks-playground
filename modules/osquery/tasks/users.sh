#!/usr/bin/env bash

osqueryi "SELECT u.uid, u.gid, u.username, g.groupname, u.description FROM users u LEFT JOIN groups g ON (u.gid = g. gid)"
