#!/usr/bin/env python

import os
import colored
from colored import stylize

print(stylize(os.environ['PT_message'], colored.fg("red")))
