# Targetting hosts with bolt using an Ansible inventory

Note that the following is a demonstration of what's possible, rather than any sort of best practice. 

Ansible supports listing hosts in an inventory file. At the simple end this is just an INI or YAML file, but the format supports various dynamic flavours, variable expansion, ranges, etc. This makes parsing arbitrary ansible inventories non-trivial.

Bolt takes a `--nodes` argument of a command-separated list of hosts. It would in some cases be handy for existing ansible users trying out bolt to reuse the inventory. Here is an example of how to do that.

Take the following static inventory:

```ini
mail.example.com

[webservers]
foo.example.com
bar.example.com

[dbservers]
one.example.com
two.example.com
three.example.com
```

Ansible supports the ability to list hosts for a particular group with `--list-hosts`. With a bit of shell foo we can convert that to the format required by `bolt`:

```
ansible <group> -i inventory --list-hosts | tail -n +2 | awk -vORS=, '{ print $1 }' | sed 's/,$/\n/'
```

For example:

```
$ ansible dbservers -i inventory --list-hosts | tail -n +2 | awk -vORS=, '{ print $1 }' | sed 's/,$/\n/'
one.example.com,two.example.com,three.example.com
```

```
$ ansible all -i inventory --list-hosts | tail -n +2 | awk -vORS=, '{ print $1 }' | sed 's/,$/\n/'
mail.example.com,foo.example.com,bar.example.com,one.example.com,two.example.com,three.example.com
```

This could be used inline with `bolt` like so:

```
bolt command run <command> --nodes `ansible all -i inventory --list-hosts | tail -n +2 | awk -vORS=, '{ print $1 }' | sed 's/,$//'`
```
