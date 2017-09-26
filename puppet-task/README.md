# Run ad-hoc Puppet manifests with Bolt

Bolt can be used to upload and run arbitrary scripts on remote nodes. If those nodes have Puppet installed on them then you can easily run arbitrary Puppet code using this feature.

First lets create a simple manifest. Note the shebang line of `#!/opt/puppetlabs/puppet/bin/puppet apply`. This means when the script is executed it should be run with `puppet apply`. The manifest itself it just a simple Puppet example of ensuring a file is present with some specific content.

```puppet
#!/opt/puppetlabs/puppet/bin/puppet apply

file { '/tmp/bolt':
  ensure  => present,
  content => 'bolt hello world',
}
```

We can run this against a list of nodes like so:

```
bolt script run manifest.pp -n <nodes>
```

This should result in a response something like the following. We see the standard Puppet output and a notice about the newly created file.

```
bolt_ssh_1:

Notice: Compiled catalog for cea827639e13 in environment production in 0.02 seconds
Notice: /Stage[main]/Main/File[/tmp/bolt]/ensure: defined content as '{md5}74d9194aec98b3f9d75912afdca19732'
Notice: Applied catalog in 0.02 seconds

Ran on 1 node in 5.63 seconds
```

We can use `bolt` to check on the file as well:

```
$ bolt command run "cat /tmp/bolt"
bolt_ssh_1:

bolt hello world
Ran on 1 node in 0.07 seconds
```

If we ran the same manifest again, against the same node, we should see the idempotent nature of Puppet in that the file already exists with the content and so no notice is present indicating a change occured.

```
bolt_ssh_1:

Notice: Compiled catalog for cea827639e13 in environment production in 0.02 seconds
Notice: Applied catalog in 0.02 seconds

Ran on 1 node in 5.65 seconds
```
