# Dynamic node lists

`bolt` takes a list of nodes as a comma-separated list of host names. But what if you want to determine that list dynamically? Maybe based on some CMDB or other database, or based on an API query? You can do this using standard shell, depending on your operating system.

One Windows we can use `/f`. Here is a simple example


```
for /f %a in ('powershell -Command "'test' + (1..10 -join ',test')"') do bolt command run <command> -n %a
```

This would be the equivalent of running the following, with nodes up to `test10`:

```
bolt command run <command> -n test1,test2,test3...
```


You are likely to want to do something more complex, in which case moving the collection of nodes to run against into a separate script is likely useful. This could be written in any language you prefer but lets look at a simple Python example:

```python
nodes = []
for i in range(125):
    nodes.append("test%s" % i)

print(','.join(nodes))
```

This prints the nodes `test0` up to `test124`. You can have that data used by `bolt` like so. On Windows:


```
for /f %a in ('python nodes.py') do bolt command run <command> -n %a
```

Or on Linux:

```
bolt command run <command> -n `python nodes.py`
```
