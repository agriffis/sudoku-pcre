# sudoku-pcre

Solve a [Sudoku](https://en.m.wikipedia.org/wiki/Sudoku) in two
[PCRE](https://en.m.wikipedia.org/wiki/Perl_Compatible_Regular_Expressions) subsitutions.

Given an input like this:

```
0 0 0 4 0 0 0 0 0
0 0 0 0 0 2 0 7 0
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 4 1 0
0 0 9 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 6 7
0 0 0 0 0 0 0 0 0
0 7 6 3 0 0 0 0 0
```

The first substitution replaces zeros with the possible digits for each
cell:

```
123456789 123456789 123456789 4         123456789 123456789 123456789 123456789 123456789
123456789 123456789 123456789 123456789 123456789 2         123456789 7         123456789
123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789
123456789 123456789 123456789 123456789 123456789 123456789 4         1         123456789
123456789 123456789 9         123456789 123456789 123456789 123456789 123456789 123456789
123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789
123456789 123456789 123456789 123456789 123456789 123456789 123456789 6         7
123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789
123456789 7         6         3         123456789 123456789 123456789 123456789 123456789
```

The second substitution searches for a valid solution:

```
9 8 7 4 6 5 3 2 1
6 5 4 1 3 2 9 7 8
3 2 1 9 8 7 6 5 4
8 6 5 7 9 3 4 1 2
7 4 9 8 2 1 5 3 6
2 1 3 6 5 4 7 8 9
5 3 8 2 4 9 1 6 7
1 9 2 5 7 6 8 4 3
4 7 6 3 1 8 2 9 5
```

Languages
---------

This solver is just a [giant PCRE](./regex.txt) with language-specific
trimmings. As such it's easy to try different languages, and in particular to
compare their [PCRE engine timings](./TIMES.md).

This repo contains implementations in Perl, Python, Ruby, and JavaScript (Node).
