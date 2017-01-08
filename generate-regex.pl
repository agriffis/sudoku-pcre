#!/usr/bin/env perl
#
# generate-regex.pl - Generate the PCRE used in solver.pl
#
# Written in 2007 by Aron Griffis <aron@n01se.net>
# and released into the public domain.

use warnings;
use integer;

sub xy2i {
    my $x = shift;
    return map($_ * 9 + $x, @_);
}

sub yx2i {
    my $y = shift;
    return map($y * 9 + $_, @_);
}

sub i2sq {
    my $i = shift;
    $x = $i % 9;
    $y = $i / 9;
    $i = ($y / 3) * 27 + ($x / 3) * 3;
    return (
        $i+0, $i+1, $i+2,
        $i+9, $i+10, $i+11,
        $i+18, $i+19, $i+20,
    );
}

$re = "\\A\n\n";
for ($i = 0; $i < 81; $i++) {
    $re .= '\d*';

    # pre-capture tests:
    # - can't be the same as anything previous in this column
    @col = xy2i($i%9, 0..($i/9-1));
    # - can't be the same as anything previous in this row
    @row = yx2i($i/9, 0..($i%9-1));
    # - can't be the same as anything previous in this square
    @sq = grep($_<$i, i2sq($i));
    $j = -1;
    @pre = grep {($_ != $j) and $j = $_, 1} sort {$a <=> $b} @col, @row, @sq;
    if (@pre) {
        $re .= '(?!' . join('|', map("\\".($_+1), @pre)) . ")\n";
    }

    # capture
    $re .= "(\\d)\n";

    # post-capture tests, purely optimizations:
    # - can't be the same as anything known (ahead) in this column
    $re .= "(?!(?:.*\\n)+(?:.{10}){".($i%9)."}\\".($i+1)."\\b)\n";
    # - can't be the same as anything known (ahead) in this row
    $re .= "(?!\\d*\\ (?:.{10})*?\\".($i+1)."\\b)\n";
    # - can't be the same as anything known (ahead) in this square
    if ($i%3 < 2) {
        $re .= "(?!\\d*\\ (?:.{10}){0,".(1-$i%3)."}\\".($i+1)."\\b)\n";
    }
    if (($i/9)%3 < 2) {
        $re .= "(?!(?:.*\\n){1,".(2-($i/9)%3)."}(?:.{30}){".(($i%9)/3)."}".
            "(?:.{10}){0,2}\\".($i+1)."\\b)\n";
    }

    $re .= "\\d*\\s+\n\n";
}
$re .= "\\Z\n";

printf "# %s\n", '$LastChangedRevision: 2391 $';
print $re;
