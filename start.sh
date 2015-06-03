#!/usr/bin/bash

# Redirect stdout to log, and stderr to stdout
python bitmessagemain.py >/var/log/pybitmessage.log 2>&1
