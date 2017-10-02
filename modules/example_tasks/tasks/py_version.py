#!/usr/bin/env python

import json
import sys

minor = sys.version_info

result = { "major": sys.version_info.major, "minor": sys.version_info.minor }

json.dump(result, sys.stdout)
