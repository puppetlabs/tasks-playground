# Run Bolt from Docker

Rather than install a full Ruby development environment locally in order to install `bolt` you can use it from Docker. The Dockerfile in this directory needs to be run from within the source directory of bolt, so you'll first need to check that out. The following commands should work if run from this directory:

```
git clone https://github.com/puppetlabs/bolt.git
cp Dockerfile bolt
cd bolt
docker build -t puppet/bolt .
```

Using bolt from Docker is as simple as:

```
docker run puppet/bolt
```

From there you can mount directories (of modules or scripts you want to run, or ssh keys you have available) or pass any relevant environment variables required for configuration.
