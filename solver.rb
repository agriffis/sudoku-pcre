#!/usr/bin/env ruby
#
# solver.rb - Solve a sudoku in two PCRE substitutions
#
# Written in 2007 by Aron Griffis <aron@n01se.net>
# and released into the public domain.

$VERBOSE = true  # same as -w

puz = gets(nil)
print "INPUT:\n#{puz}\n"

regex = File.read('regex.txt')

puz.gsub!(%r{\d}) {|x| x == '0' ? '123456789' : x+'        ' }
md = puz.match %r{
    #{regex}
}x

print "OUTPUT:\n"
printf "%s %s %s %s %s %s %s %s %s\n" * 9, *md.captures
