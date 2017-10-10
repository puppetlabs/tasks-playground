Bolt bash completion
====================

Bash completion for [bolt](https://github.com/puppetlabs/bolt). Completion
works for bolt options when run directly or via `bundle exec` and expands nodes
from `~/.ssh/config`.

## Installation

Global:

    $ sudo cp bolt /etc/bash_completion.d/
    $ . /etc/bash_completion.d/bolt

OSX Global:

    $ sudo cp bolt /etc/bash_completion.d/
    $ . /etc/bash_completion.d/bolt

Local:

    $ cp bolt ~/bash_completion.d/
    $ . ~/bash_completion.d/bolt

## Usage

    $ bolt [TAB]
    $ bundle exec bolt [TAB]
    $ bolt -[TAB]
    $ bolt --nodes [TAB]
    $ bolt --nodes node1,[TAB]

