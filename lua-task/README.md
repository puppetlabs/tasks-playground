# Writing Puppet Tasks with Lua

Lua is an interpreted language that also takes advantage of some runtime compilation features. This is an example task only to prove that you can write tasks in Lua, too!

## Write it!
You might do something like this (don't forget that shebang) :
```lua
#!/usr/bin/lua

print(os.getenv('PT_message'))

```

Or just go nuts for no reason:
```lua
#!/usr/bin/lua

msg = function() local message = os.getenv('PT_message'); return message end

print(msg())
```

## Run it!
Try running your Lua task on any node with Lua installed.

```
$ bolt task run sample message='hello world' --nodes <nodes> --modules ./modules
node:

hello world


Ran on 1 node in 1.23 seconds
```
