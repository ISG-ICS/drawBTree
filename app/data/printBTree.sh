#!/bin/bash - 
#===============================================================================
#
#          FILE: dot.sh
# 
#         USAGE: ./dot.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Jianfeng Jia (), jianfeng.jia@gmail.com
#  ORGANIZATION: ics.uci.edu
#       CREATED: 04/26/2015 22:31:20 PDT
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

[ $# -lt 1 ] && { echo "error: please provide at least one btree json file."; exit 1; }

for var in "$@"; do
    output=${var}.svg
    tmpDot=`mktemp -t .tree.dot.XXXX` || { echo "create tmp file failed" ; exit 1; }
    python data/convertJson2Dot.py $var > $tmpDot
    [ $? -eq 0 ] || { echo "convertJson2Dot failed, please validate your json file: $var"; exit 2;}
    dot -Tsvg $tmpDot -o $output
    [ $? -eq 0 ] || { echo "create graph from dot file failed : $var"; exit 3;}
    echo "The graph of \"${var}\" is output to \"$output\""
done

