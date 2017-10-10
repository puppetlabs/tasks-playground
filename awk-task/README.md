# Writing Puppet Tasks with Awk

Awk can be used as a scripting language, though it's hard to imagine a reason to do that. Nonetheless...

```awk
#!/usr/bin/awk -f

{
  printf "%s\n", ENVIRON["PT_message"]
}
```

Now it can be run on any node that has `awk` installed.

```
$ bolt task run sample message='Hello world' --nodes <nodes> --modules ./modules
bolt_ssh_1:

Hello world

Ran on 1 node in 2.98 seconds
```
