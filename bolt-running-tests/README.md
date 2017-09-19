# Using Bolt to run tests against nodes

One of the useful things we can do with bolt is run a set of tests against a large number of nodes at the same time. Those tests might be written in a formal test framework, or just handy scripts which make assertions against the state of the system. 

## Bats

`bats` is handy testing framework written in bash we can use to demonstrate this. You could write tests for all sorts of policy type assertions you want to make, and then easily demonstrate to colleagues that all nodes are correctly configured.

Note that for the following examples nodes need to have [bats](https://github.com/sstephenson/bats) installed. The `bats` documentation has a section for [installation instructions](https://github.com/sstephenson/bats/wiki/Install-Bats-Using-a-Package).  

First lets write some simple `bats` tests. We'll start with checking whether anything is listening on certain ports:

```bash
#!/usr/bin/env bats

@test "Test that nothing is listening on port 80" {
    run lsof -i :80
    [ "$status" -eq 1 ]
}

@test "Test that something is listening on port 22" {
    run lsof -i :22
    [ "$status" -eq 0 ]
}
```

`bolt` can upload the above script and execute it on the remote nodes using the `script` subcommand:

```
bolt script run something.bats -n <nodes>
```

This should result in output like the following, assuming we run against a single node which has something listening on port 22 and nothing listening on port 80.

```
bolt_ssh_1:

 ✓ Test that nothing is listening on port 80
 ✓ Test that something is listening on port 22

2 tests, 0 failures

Ran on 1 node in 1.19 seconds
```

## Shellshock

We might also want to use scripts written by third parties, for instance scripts that check nodes for known vulerabilities. Lets use [bashcheck](https://raw.githubusercontent.com/hannob/bashcheck/master/bashcheck) as an example. It checks nodes for the [ShellShock](https://en.wikipedia.org/wiki/Shellshock_(software_bug) vulnerability.

```
bolt script run bashcheck -n <nodes>
```

This should hopefully result in a response like the following. If the script indicates issues you know you have work to do to upgrade the affected nodes.

```
bolt_ssh_1:

Testing /bin/bash ...
Bash version 4.3.11(1)-release

Variable function parser pre/suffixed [%%, upstream], bugs not exploitable
Not vulnerable to CVE-2014-6271 (original shellshock)
Not vulnerable to CVE-2014-7169 (taviso bug)
Not vulnerable to CVE-2014-7186 (redir_stack bug)
Test for CVE-2014-7187 not reliable without address sanitizer
Not vulnerable to CVE-2014-6277 (lcamtuf bug #1)
Not vulnerable to CVE-2014-6278 (lcamtuf bug #2)

Ran on 1 node in 0.64 seconds
```
