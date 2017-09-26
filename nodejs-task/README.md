# Writing Puppet Tasks with Node.js

[Node.js](https://nodejs.org) provides a runtime for Javascript, and makes a nice environment for writing Puppet Tasks with. One approach to using Node is to ensure the runtime is already installed on on of the nodes you want to run tasks on. If that's the case then the simplest task would be a single `.js` file.

Save the following as `modules/sample/tasks/init.js`:

```javascript
#!/usr/bin/env node
console.log(process.env.PT_message);
```

The above creates a module called `sample` with a default task (indicated by the name `init`). We can run that with `bolt` like so:

```
$ bolt task run sample message=hello --nodes <nodes> --modules ./modules
bolt_ssh_1:

hello

Ran on 1 node in 1.37 seconds
```


## Removing the need to install Node.js on nodes

As noted, the above assumes the node runtime is already installed on the nodes. We can remove even that limitation if we use [pkg](https://github.com/zeit/pkg). `pkg` packages up out node application, it's dependencies and the runtime itself into a single executable that's perfect as a Puppet Task.

First install `pkg` with:

```
npm install -g pkg
```

Then package up our above script. Note that:

* We're only building the linux executable here, but `pkg` supports Windows and macOs as well
* We're outputting a single executable called `full`, but the name could be any valid task name

```
cd modules/sample/tasks
pkg -o full -t node8-linux-x64 init.js
```

This should create a file called `full`. Because `bolt` can automatically detect tasks based on unique filenames we can just run that from the top level directory like any other task.

```
bolt task run sample::full message=hello --nodes <nodes> --modules ./modules
```
