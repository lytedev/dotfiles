#!/usr/bin/env python

import os

fh = open("twmn.template.conf", 'r')
s = fh.read()
fh.close()

e = os.environ
e['SECONDARY_FONT_SIZE'] = str(round(int(e['SECONDARY_FONT_SIZE']) * 4/3))

fh = open("twmn.conf", 'w')
fh.write(s.format(**e))
fh.close()
