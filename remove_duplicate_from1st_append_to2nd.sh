#!/bin/bash
#
# sample data
#cat test1
#www.xyz.com/abc-1
#www.xyz.com/abc-2
#www.xyz.com/abc-3
#
#cat test2
#www.xyz.com/abc-2
#www.xyz.com/abc-3
#

diff test1 test2 |grep "<"|sed  's/< \+//g' > test1.tmp|mv test1.tmp test1

cat test1 >> test2
