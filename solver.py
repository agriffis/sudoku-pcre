#!/usr/bin/env python
#
# solver.py - Solve a sudoku in two PCRE substitutions
#
# Written in 2007 by Aron Griffis <aron@n01se.net>
# and released into the public domain.

from __future__ import absolute_import, print_function, unicode_literals

import sys, re

puz = sys.stdin.read()
print("INPUT:\n{}".format(puz))

regex = open('regex.txt').read()

puz = re.sub(r"[1-9]", r"\g<0>        ", puz)
input = re.sub(r"0", "123456789", puz)
output = re.sub(regex,
r"""\1 \2 \3 \4 \5 \6 \7 \8 \9
\10 \11 \12 \13 \14 \15 \16 \17 \18
\19 \20 \21 \22 \23 \24 \25 \26 \27
\28 \29 \30 \31 \32 \33 \34 \35 \36
\37 \38 \39 \40 \41 \42 \43 \44 \45
\46 \47 \48 \49 \50 \51 \52 \53 \54
\55 \56 \57 \58 \59 \60 \61 \62 \63
\64 \65 \66 \67 \68 \69 \70 \71 \72
\73 \74 \75 \76 \77 \78 \79 \80 \81""", input, flags=re.X)

print("OUTPUT:\n{}".format(output))
