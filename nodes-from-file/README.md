# Listing nodes from a text file

Rather than specifying all of the nodes on the command line you may like to store them in an accompanying test file. Let's start with a file like so:


```
web1.example.com
web2.example.com
web3.example.com
db.example.com
```

On a typical Linux machine (with `cat` and `paste` available) you can access that list of nodes with `bolt` using the following:

```
bolt command run uptime --nodes `cat nodes | paste -sd "," -`
```

On Windows you can do the same using PowerShell:

```powershell
bolt command run uptime --nodes ((Get-Content .\nodes) -join ',')
```
