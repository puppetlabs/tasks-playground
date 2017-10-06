# process

#### Table of Contents

1. [Description](#description)
1. [Usage - examples](#usage)
    * [See all running processes](#see-all-running-processes)
    * [Query running process](#query-running-process)

## Description

This module provides tasks for querying system processes. It also provides an example of a powershell task.

## Usage

### See all running processes

See all processes running on a Windows node

```
$ puppet-task run --nodes=example.com process::win
```

A similar example works on other platforms

```
$ puppet-task run --nodes=example.com process::nix
```

### Querry running process

Get structured data about one or more running processes

```
$puppet-task run <target> process::win name='IIS*'
```

A similar example works on other platforms

```
$ puppet-task run <target> process::nix name='.*d'
```

Note that the patterns used to match process names may differ on Windows vs other
platforms. Windows uses `Get-Process`, others use `grep`.
