#!/usr/bin/env python

import json
import os
import signal
import sys
import time

SIGNALS = {
  'term': signal.SIGTERM,
  'kill': signal.SIGKILL,
}

params = json.load(sys.stdin)

job_id = params['job_id']
signal = SIGNALS[params.get('signal', 'kill')]
timeout = params.get('timeout', 1)

def task_file(job_id, filename):
  "Traverse up from the task file -> the spool"
  return os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..', 'spool', job_id, filename))

def make_error(kind, msg, details=None):
  "Make and task_error response"
  return {
     "_error": {
       "kind": kind,
       "msg": msg,
       "details": details or {},
       }
     }

pid_file = task_file(job_id, 'pid')
try:
  with open(pid_file) as fh:
    pid = int(fh.read())
except IOError:
  json.dump(make_error("file-not-found", 'could not find pid file: %s' % pid_file, {"path": pid_file}), sys.stdout)
  exit(5)

status = "running"
for i in range(timeout):
  try:
    os.kill(pid, signal)
  except OSError as e:
    # This is the error when the pid isn't found
    if e[0] == 3:
      if i == 0:
        status = "finished"
      else:
        status = "killed"
      break
    else:
      json.dump(make_error("process_error", e[1], {"pid": pid}), sys.stdout)
      exit(1)
  time.sleep(1)

json.dump({"status":  status}, sys.stdout)
