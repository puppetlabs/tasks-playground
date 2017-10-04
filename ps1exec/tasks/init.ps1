#!/usr/bin/env powershell

Param([Parameter(Mandatory=$True)] [String] $Command)

Invoke-Expression $Command
