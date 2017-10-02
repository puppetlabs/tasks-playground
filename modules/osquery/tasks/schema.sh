#!/usr/bin/env bash

"${PT_table:?Need to specify a table, for example table=users}"

osqueryi ".schema ${PT_table}"
