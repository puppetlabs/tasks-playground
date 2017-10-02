# Building your own user interface for existing tools

A handy use of `bolt` is to provide a shared user interface to existing tools. By encapsulating commonly run commands in a Puppet Task it's easier to discover and easier to share within a team.

As an example let's look at [osquery](https://osquery.io/), a tool for querying the state of a host via a SQL interface. The init task for the osquery provides a shortcut into the `osqueryi` command. But with `bolt` we can easily run those commands across all of you nodes.

Note that you can find all the code for the `osquery` tasks in `modules/osquery/tasks`. They consist of only a few lines of bash in this case.

Here's a quick example of listing all of the network routes for all the specified hosts.


```
$ bolt task run osquery query="SELECT * FROM routes" --nodes <nodes> --modules ./modules
bolt_ssh-osquery_1:

+-----------------+---------+------------+------------+-------+-----------+-----+--------+-----------+
| destination     | netmask | gateway    | source     | flags | interface | mtu | metric | type      |
+-----------------+---------+------------+------------+-------+-----------+-----+--------+-----------+
| 0.0.0.0         | 0       | 172.18.0.1 |            | 0     | eth0      | 0   | 0      | gateway   |
| 172.18.0.0      | 16      |            | 172.18.0.4 | 0     | eth0      | 0   | 0      | gateway   |
| 127.0.0.0       | 0       |            | 127.0.0.1  | 0     | lo        | 0   | 0      | broadcast |
| 127.0.0.0       | 8       |            | 127.0.0.1  | 0     | lo        | 0   | 0      | local     |
| 127.0.0.1       | 0       |            | 127.0.0.1  | 0     | lo        | 0   | 0      | local     |
| 127.255.255.255 | 0       |            | 127.0.0.1  | 0     | lo        | 0   | 0      | broadcast |
| 172.18.0.0      | 0       |            | 172.18.0.4 | 0     | eth0      | 0   | 0      | broadcast |
| 172.18.0.4      | 0       |            | 172.18.0.4 | 0     | eth0      | 0   | 0      | local     |
| 172.18.255.255  | 0       |            | 172.18.0.4 | 0     | eth0      | 0   | 0      | broadcast |
| 0.0.0.0         | 0       |            |            | 0     | lo        | 0   | -1     | other     |
| 0.0.0.0         | 0       |            |            | 0     | lo        | 0   | -1     | other     |
+-----------------+---------+------------+------------+-------+-----------+-----+--------+-----------+

Ran on 1 node in 0.37 seconds
```


The above example relies on your knowing the SQL query to run. That's obviously great if you're an `osquery` expert, but less useful when you're in a hurry or new to the tooling. In those cases it's nice to store oft-used queries as separate tasks. Rather than taking the query as an argument we've embedded a few queries in the tasks. Here are a few examples, the first one lists the processes listening on open ports:

```
$ bolt task run osquery::listening --nodes <nodes> --modules ./modules
bolt_ssh-osquery_1:

+------+------+-----+
| name | port | pid |
+------+------+-----+
| sshd | 22   | 1   |
+------+------+-----+

Ran on 1 node in 0.40 seconds
```

`osquery::processes` lists all running processes along with details of the command running:

```
$ bolt task run osquery::processes --nodes <nodes> --modules ./modules
bolt_ssh-osquery_1:

+-----+-------------+-------------------------------------------------+
| pid | name        | cmdline                                         |
+-----+-------------+-------------------------------------------------+
| 1   | sshd        | /usr/sbin/sshd -D                               |
| 260 | sshd        | sshd: root@notty                                |
| 263 | sftp-server | /usr/lib/openssh/sftp-server                    |
| 265 | bash        | bash /tmp/tmp.1Lnag0jU0t/processes.sh           |
| 266 | osqueryi    | osqueryi SELECT pid,name,cmdline FROM processes |
+-----+-------------+-------------------------------------------------+

Ran on 1 node in 0.41 seconds
```

`osquery::users` will list all users installed available on each node:

```
$ bolt task run osquery::users --nodes <nodes> --modules ./modules
bolt_ssh-osquery_1:

+-------+-------+----------+-----------+------------------------------------+
| uid   | gid   | username | groupname | description                        |
+-------+-------+----------+-----------+------------------------------------+
| 0     | 0     | root     | root      | root                               |
| 1     | 1     | daemon   | daemon    | daemon                             |
| 2     | 2     | bin      | bin       | bin                                |
| 3     | 3     | sys      | sys       | sys                                |
| 4     | 65534 | sync     | nogroup   | sync                               |
| 5     | 60    | games    | games     | games                              |
| 6     | 12    | man      | man       | man                                |
| 7     | 7     | lp       | lp        | lp                                 |
| 8     | 8     | mail     | mail      | mail                               |
| 9     | 9     | news     | news      | news                               |
| 10    | 10    | uucp     | uucp      | uucp                               |
| 13    | 13    | proxy    | proxy     | proxy                              |
| 33    | 33    | www-data | www-data  | www-data                           |
| 34    | 34    | backup   | backup    | backup                             |
| 38    | 38    | list     | list      | Mailing List Manager               |
| 39    | 39    | irc      | irc       | ircd                               |
| 41    | 41    | gnats    | gnats     | Gnats Bug-Reporting System (admin) |
| 65534 | 65534 | nobody   | nogroup   | nobody                             |
| 100   | 101   | libuuid  | libuuid   |                                    |
| 101   | 104   | syslog   | syslog    |                                    |
| 102   | 65534 | sshd     | nogroup   |                                    |
+-------+-------+----------+-----------+------------------------------------+

Ran on 1 node in 0.39 seconds
```
