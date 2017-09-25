# Writing Puppet Tasks in Python

Tasks for `bolt` can be written in any language, they just require the runtime to be available on the target node. Let's have a look at writing simple Python tasks to illustrate this.

Save the following as `modules/sample/tasks/init.py`.

Note that the `sample` part is the name of our module. We could have used anything here but note it's used to build out the user interface as we'll see in a moment.

```python
#!/usr/bin/env python
import os
print os.environ['PT_message']
```

Note as well that this is just a standard Python script. It's using the standard library `os` module and then printing out the `PE_message` environment variable. Task arguments are automatically passed along to tasks and prefixed with `PT_` for Puppet Tasks.

The name `init` is special. It means this task is the default for this module, so if you don't explicitly run a named task the `init` task will be run. Here's an example of running that task.

```
bolt task run sample message=hello --nodes <nodes> --modules ./modules
```

Note:

* the `--modules` flag points at the modules diretory we created above with out `sample` module in
* the argument `message` matches the name of our environment variable above
* `sample` is the name of our module. We're not naming a task explicitly so bolt will run the `init` task

This is a simple way of running any arbitrary Python code on a large number of remote nodes, and packaging that code up so it's easy to share with the rest of your team or the wider community.


## Managing dependencies

The above example just uses the Python standard library. But what if our task wants to use a third party library? We could just install that library on our remote machines, but that requires upfront configuration which might not always be possible. It would be nice if we could rely just on the runtime and nothing else. Lucily with [Pex](https://github.com/pantsbuild/pex) we can do exactly that.

Pex is a packaging format for Python which packages up our code along with any required libraries and can create a single executable. Perfect for distribution with `bolt`. Let's see a very simple example of doing that.

To create a Pex package we need to have a `setup.py` file. A simple example might look like the following:

```python
from distutils.core import setup

setup(
    name='samplepkg',
    version='0.1',
    packages=['samplepkg'],
)
```

All of the code samples needed to run this example accompany this README.

Next we need to write the code for our task. We'll save that to `samplepkg/main.py`.

```python
#!/usr/bin/env python

import os
import colored
from colored import stylize

print(stylize(os.environ['PT_message'], colored.fg("red")))
```

We'll also need a blank file at `samplepkg/__init__.py` to indicate that `samplepkg` is a Python package.

Note in the above we're using the [colored](https://pypi.python.org/pypi/colored) Python package from PyPi. We're using that to style the printing of the output in red.

Finally we need to build the pex package. For that you'll need to install Pex:

```
pip install pex
```

And finally build the intermediary wheel and save the `.pex` file to our tasks folder.

```
pip wheel -w . .
pex -f ${PWD} samplepkg colored -e samplepkg.main -o modules/sample/tasks/samplepkg.pex
```

We can now run our task. Note the `::samplepkg` part of the command below. `::` separates the module name from the task name. `samplepkg` is the filename of our `pex` file above.

```
bolt task run sample::samplepkg message=color --nodes <nodes> --modules ./modules
```

This should print out the message in red rather than the default terminal color. Obviously printing output in a different color is just a simple example of the kinds of things you can do. This approach makes it trivial to use the huge Python ecosystem of libraries to help write tasks to automate your infrastructure.
