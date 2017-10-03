# Installing tasks with r10k

Tasks are distributed as Puppet modules, which means existing tooling that works with Puppet modules already supports tasks. We can demonstrate that by using [librarian-puppet](https://github.com/puppetlabs/r10k) and a `Puppetfile` to download and manage a set of modules.

The following assumes you have a Ruby environment available. First install `r10k` and it's dependencies.

```
gem install r10k
```

We then need a `Puppetfile` which describes the modules we want to download. We're referencing the GitHub repositories for the modules for now because they modules are currently private and only available internally.

```
forge "https://forgeapi.puppetlabs.com"

mod 'puppetlabs-package',
  :git => "https://github.com/puppetlabs/puppetlabs-package.git"

mod 'puppetlabs-service',
  :git => "https://github.com/puppetlabs/puppetlabs-service.git"
```

We then run `r10k` to download the modules to the `./modules` folder.

```
r10k puppetfile install --moduledir modules
```

This should create a `./modules` folder if one doesn't already exist and download the `package` and `service` module.

```
$ ls modules
package  service
```

With those modules downloaded we can use them with `bolt` using the `--modules` flag.

```
bolt task run package action=status package=vim --modules ./modules --nodes <nodes>
```

Assuming we run this against an Ubuntu machine without vim installed you can expect to see output like the following:

```
bolt_ssh_1:

{"status":"absent","latest":"2:7.4.052-1ubuntu3.1"}

Ran on 1 node in 4.40 seconds
```
