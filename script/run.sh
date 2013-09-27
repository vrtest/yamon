#!/bin/bash

APP_DIR=/data/www/yamon
ENV=$1

if [ "x$ENV" == "x" ]
then
  ENV=production
fi

if [ $ENV == "production" ]
then
  PORT=3005
else
  PORT=3105
fi

test -d $APP_DIR/tmp/pids || mkdir $APP_DIR/tmp/pids

cd $APP_DIR
$APP_DIR/script/rails server -b 127.0.0.1 -d -p $PORT -e $ENV

PID=`ps aux|grep -e "ruby.*$PORT"|grep -v -e "grep" -e "run.sh"|tail -n1|awk '{print $2}'`
echo " * PID is [$PID]"
echo $PID > $APP_DIR/tmp/pids/$ENV.pid
