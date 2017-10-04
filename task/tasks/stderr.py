#!/usr/bin/env python
import json
import os
import sys

params = json.load(sys.stdin)

job_id = params['job_id']


def task_file(job_id, filename):
  "Traverse up from the task file -> the spool"
  return os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..', 'spool', job_id, filename))

def error(code=1, kind="runtime-error", msg="unexpected error running task", details=None):
  "Make and task_error response"
  result =  {
     "_error": {
       "kind": kind,
       "msg": msg,
       "details": details or {},
       }
     }
  json.dump(result, sys.stdout)
  exit(code)

stderr_file = task_file(job_id, 'stderr')
try:
  with open(stderr_file) as fh:
    stderr = fh.read()
except IOError:
  error(5, "file-not-found", 'could not find file: %s' % pid_file, {"path": stderr_file})

json.dump({"stderr": stderr}, sys.stdout)
