# Writing Puppet Tasks with Perl

Perl can be a useful language to write tasks in for some organisations. Especially in a Linux environment the Perl runtime is very likely to already be installed on the node. And lots of organisations have a collection of useful Perl scripts which can quickly be moved into a module and then easily run across a collection of nodes.

Here's a very simple Perl script which reads the value of an environment variable and prints it out. Note the `PT_` prefix used by Puppet Tasks to indicate arguments passed to the task by the task runner. Save the following to `modules/sample/tasks/init.pl`

```perl
#!/usr/bin/env perl
$userName =  $ENV{'PT_message'};
print "Hello, $userName\n";
```

You can then run the above task like so, assuming the target nodes do indeed have the Perl runtime installed.

```
$ bolt task run sample message=bolt --nodes <nodes> --modules ./modules
bolt_ssh_1:

Hello, bob

Ran on 1 node in 0.40 seconds
```
