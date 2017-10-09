# Ephemeral SSH servers

When experimenting with `bolt` it's useful to have a bunch of machines running SSH to hand. What better way to grab a large number of SSH servers locally than with Docker? The advantage of this approach is speed (we can launch 100 SSH servers in seconds) and low overhead (we can do all of that locally). It's a great way to experiment with `bolt` across a large number of nodes, without needing to provision new infrastructure or jump straight to production.


The following assumes you have Docker installed along with `docker-compose`. Compose will build an SSH server image with Puppet installed, so you can also experiment with the tasks which require the Puppet runtime to be present. You can launch with:

```
docker-compose up -d --scale ssh=<num>
```

Just provide a suitable value for the number of SSH nodes you would like to launch. 

```
docker-compose up -d --scale ssh=100
```

With your new SSH servers running you probably want to connect to them. For that we'll use the `bolt` Docker image described elsewhere, so we can connect to the Docker network automatically created by Compose. You'll need to [build your own image](../docker-image/) before running the following commands.

```
docker run -it --net bolt_default puppet/bolt command run uptime -n bolt_ssh_1 -u root -p root
```

We can get fancy as well and hit all of the containers we just started. On Windows we can do something like the following to provide the full list of sequential container names to bolt:

```
for /f %a in ('powershell -Command "'bolt_ssh_' + (1..100 -join ',bolt_ssh_')"') do docker run -rm -it --net bolt_default puppet/bolt command run uptime -n %a -u root -p root
```

Finally remember to stop all of the containers you started up:

```
docker-compose rm -fs
```


