#!/bin/sh
CMD="grunt staging server:local "
CMD+="$@"
echo $CMD
$CMD