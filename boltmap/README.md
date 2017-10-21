# boltmap: Sourcing bolt nodes from a YAML file

A super simple Ruby script that can be used to output a list of nodes in a format that's acceptable to the bolt cli from YAML, inspired by [ansible-inventory](../ansible-inventory).  Not actually compatible with Ansible Inventory though.  Can provide specific YAML file on the cli or provide it via STDIN.

### Usage

`boltmap.rb [options] file`

`-g`, `--group=` `Map group to run`

### Example

`` bolt command run hostname --nodes `boltmap.rb --group=webservers ~/mymap.yaml` ``
