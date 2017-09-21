# Installing Puppet with Bolt using puppet-install-shell

[puppet-install-shell](https://github.com/petems/puppet-install-shell) is a project to maintain a set of scripts which install Puppet on a range of different Linux flavours.

The script can be downloaded and piped to `sh` as indicated in the documentation, alternatively you can download the script locally and then use `bolt script` to upload and run it.

```
wget https://raw.githubusercontent.com/petems/puppet-install-shell/master/install_puppet_5_agent.sh
bolt script run install_puppet_5_agent.sh --nodes <nodes>
```

That should output various installation steps and result in Puppet being installed from the official Puppet packages.You can verify that with bolt itself.

```
$ bolt command run "/opt/puppetlabs/bin/puppet --version" --nodes <nodes>
bolt_ssh_1:

5.2.0

Ran on 1 node in 0.68 seconds
```
