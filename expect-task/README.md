# Tasks Hello World

Tasks allow you to share commonly used commands as Puppet modules. This means they can be uploaded and downloaded from the Forge, as well as managed using all the existing Puppet tools. You can also just use them from GitHub or as a way of organising regularly used commands locally.

By default tasks take arguments as environment variables, prefixed with `PT` (short for Puppet Tasks). Tasks are stored in the `tasks` directory of a module, a module just being a directory with a unique name. You can have several tasks per module, but the `init` task is special and will be run by default if a task name is not specified. All of that will make more sense if we see it in action.

Note that tasks can be implemented in any language which will run on the target nodes. We'll use `sh` here purely as a simple demonstration, but you could use Perl, Python, Lua, Javascript, etc. as long as it can read environment variables or take content on stdin.

Save the following file to `./modules/sample/tasks/init.exp`:

```
#!/usr/bin/expect

# Don't output commands as they run
log_user 0

# Get hostname and trim the trailing newline
spawn hostname
expect {\$}
set hostname [string trimright $expect_out(buffer)]

# output the message
puts "$hostname got passed the message: $env(PT_message)"
```

We can then run that task using `bolt` like so. Note the `message` argument. This will be expanded to the `PT_message` environment variable expected by our task.

```
bolt task run sample message=hello <nodes> --modules ./modules
```

This should result in output similar to:

```
bolt_ssh_1:

bolt_ssh1 got passed the message: hello

Ran on 1 node in 0.39 seconds
```

Try running the `bolt` command with a different value for `message` and you should see the expected results.
