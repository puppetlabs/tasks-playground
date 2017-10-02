# Writing Puppet Tasks in Go

Tasks for `bolt` can be written in any language, including compiled languages. Let's have a look at writing simple Go tasks to illustrate this.

`go_task` is the name of our module, it will be used in the `bolt` user interface in a moment. Then save the following code as `main.go`:

```go
package main

import (
    "fmt"
    "os"
)

func main() {
    fmt.Println(os.Getenv("PT_message"))
}
```

Note that this is just a standard Go programme. It's using the standard library `fmt` module and then printing out the `PE_message` environment variable. Task arguments are automatically passed along to tasks and prefixed with `PT_` (short for Puppet Tasks).

We need to compile the task into a standalone executable for the target platform. Go has excelent support for cross-compilation. Let's assume we're targetting a Linux host. On macOS or Linux you can run:

```bash
GOOS=linux GOAARCH=amd64 go build -o tasks/main
```

On Windows the syntax for setting the environment variables is slightly different, but you can run the following:

```powershell
set GOOS=linux
set GOAARCH=amd64
go build -o tasks/main
```

Both of the above will produce an executable called `main` in the tasks directory of this module we created above. That''s required to be able to run the task.

```
bolt task run go_task::main message=hello --nodes <nodes> --modules ../
```

Note:

* the `--modules` flag points at the modules diretory we created above with out `sample` module in
* the argument `message` matches the name of our environment variable above
* `sample` is the name of our module and `main` is the name of our executable. These could be any valid module name and task name

This is a simple way of running any Go code on a large number of remote nodes, and packaging that code up so it's easy to share with the rest of your team or the wider community.


