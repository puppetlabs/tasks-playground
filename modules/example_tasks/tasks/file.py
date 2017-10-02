#!/usr/bin/env python

import json
import os
import sys

params = json.load(sys.stdin)
filename = params['filename']
content = params['content']
noop = params.get('_noop', False)

exitcode = 0

def make_error(msg):
  return {
      "_error": {
        "kind": "file_error",
        "msg": "Could not open file %s: %s" % (filename, str(e)),
        "details": {},
        }
      }

try:
  if noop:
    if not os.access(filename, os.W_OK):
      result = make_error("File %s is not writable" % filename)
    else:
      result = { "success": True }
  else:
    with open(filename, 'w') as fh:
      if not noop:
        fh.write(content)
      result = { "success": True }
except Exception as e:
  exitcode = 1
  result = make_error("Could not open file %s: %s" % (filename, str(e)))

json.dump(result, sys.stdout)
exit(exitcode)
