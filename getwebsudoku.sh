#!/bin/sh
#
# Written in 2007 by Aron Griffis <aron@n01se.net>
# and released into the public domain.

get()
{
    wget -qO- http://show.websudoku.com/?level=$1 \
    | grep READONLY \
    | perl -pe '
        s/<\/TR>/\n/g;
        s/MAXLENGTH/VALUE="0"/g;
        s/.*?VALUE="(\d)/$1 /g;
        s/\s\D.*$//gm'
}

get 1 | tee level-1.input$1
get 2 | tee level-2.input$1
get 3 | tee level-3.input$1
get 4 | tee level-4.input$1
