# junos: Simple show, set and delete for JUNOS

A really simple module that allows the showing, setting and deletion of arbitary items from Juniper Switches, Routers and Firewalls.
Requires my hacked up branch of bolt located at https://github.com/jonnytdevops/bolt/tree/junos
 
### Example

`bolt task run junos show='system login' set='system login user test_user1' delete='system login user test_user2' commit=true --nodes pdx-626c6-coretest.ops.puppetlabs.net`
