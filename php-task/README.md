# Writing Puppet Tasks using PHP

If you're a PHP user you'll be happy to know you can write your Puppet Tasks in PHP. You'll need PHP installed on the nodes you want to target. As a hello world example save the following as `modules/sample/tasks/init.php`:

```php
#!/usr/bin/env php
<?php
echo getenv('PT_message');
?>
```

You can then run the task like so:

```
bolt task run sample message=hello --nodes <nodes> ./modules
```

For more complex tasks, maybe with multiple files or dependencies on third party libraries, it's useful to wrap tasks up as a `.phar` (PHP archive). There are several tools that can help you do that but [box](https://box-project.github.io/box2/) is nice and simple to experiment with.

First we need to create a `box.json` configuration file. Store that alongside the `init.php` file from above in the `tasks` folder.

```json
{
    "main": "init.php",
    "output": "example.phar",
    "stub": true
}
```

Note in the above we're going to package our existing `init.php` script as `example.phar`. This will make it available as the `example` task in our `sample` module, which is referenced with `sample::example`.

We then just need to install `box` and run `box build`. If you don't have PHP and Box installed locally you can use the Dockerfile provided along with this README like so.

```
docker build -t box .
docker run -it -v ${PWD}/modules/sample/tasks:/source box build
```

This will create a file at `modules/sample/tasks/example.phar`. You can run that task like so:

```
bolt task run sample::example message=hello --nodes <nodes> ./modules
```

See the full [box documentation](https://box-project.github.io/box2/) for how to bundle libraries or add additional files to the package.
