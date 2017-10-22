# Bolt powered LLDP Query

Tasks allow you to take your existings admin scripts and package them into puppet modules, making your code repos ad-hoc task enabled. Have a script related to a puppet taks that doesn't currently need to be in catalogs? Add them to a puppet module! This example shows how you might take an LLDP script you use to validate connection maps and use tasks to run them against hosts.

Note that tasks can be implemented in any language which will run on the target nodes. This example uses `bash`, purely as a simple demonstration, but you could use Perl, Python, Lua, Javascript, etc. as long as it can read environment variables or take content on stdin.

Scripts should be under [modulename]/tasks/[script] which then namespaces natively as modulename::script


We can then run that task using `bolt` like so.

```
bolt task run lldp <nodes> --modules ./ #This assumes you're in the tasks-playground dir
```

This should result in output similar to:

```
bolt_ssh_1:

lldpad is installed

Ran on 1 node in 0.23 seconds
```

As shown above, the init script included is just a package check (would also allow install if account permissions allowed). Also included is a neighbor check to get info of attached swtiches/devices.
bolt task run lldp::neighbors <nodes> --modules ./

Try running the `bolt` command with a different value for `message` and you should see the expected results.
```
bolt_ssh_1:

eth0=myfirstswitch.mydomain.com eth1=mysecondswitch.mydomain.com

Ran on 1 node in 0.78 seconds
```
