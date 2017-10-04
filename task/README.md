# task

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with task](#setup)
    * [Beginning with task](#beginning-with-task)
1. [Usage - examples](#usage)
    * [Kill Tasks](#kill-a-running-task)
    * [Retrieve stderr](#retrieve-stderr)

## Description

This module provides tasks for interacting with other orchestrator tasks. It
also provides an example of a python task.

## Usage

### Kill a running task

If you need to kill a running task on some nodes you can use the `task::kill`
task to kill those tasks by job_id

```
$ puppet-task run --nodes=example.com task::kill job_id=42
```

### Retreive stderr

If you need to retrieve the stderr output from the execution of a task you can
use the `task::stderr task.

```
$puppet-task run <target> task::stderr job_id=42
```
