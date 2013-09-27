#!/bin/bash

ALERT_SCRIPT="./nagios-to-yamon.rb"
IFS=$'\n'

for line in `cat $1|grep "SERVICE ALERT"|grep "HARD"`
do
  hostname=`echo $line|awk -F';' '{ print $1 }'|awk '{ print $NF }'`
  service=`echo $line|awk -F';' '{ print $2 }'`
  state=`echo $line|awk -F';' '{ print $3 }'`
  lastcheck=`echo $line|awk -F';' '{ print $1 }'|awk -F';' '{ print $1 }'|awk '{ print $1 }'| awk '{sub(/\[/, "");print}'| awk '{sub(/\]/, "");print}'` #c'est moche !
  output=`echo $line|awk -F';' '{ print $6 }'`
  perfdata=`echo $line|awk -F';' '{ print $7 }'`

  case "$state" in
    CRITICAL)
      stateint=2
    ;;
    OK)
      stateint=0
    ;;
    UNKNOWN)
      stateint=3
    ;;
    WARNING)
      stateint=1
    ;;
  esac
  echo "$ALERT_SCRIPT \"$hostname\" \"$service\" \"$stateint\" \"$lastcheck\" HARD \"$output\" \"$perfdata\""
  $ALERT_SCRIPT "$hostname" "$service" "$stateint" "$lastcheck" HARD "$output" "$perfdata"
done
echo
