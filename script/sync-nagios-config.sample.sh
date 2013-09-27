#!/bin/bash
CONFIG_FILE=/var/lib/nagios3/export-services.xml
YAMON_LOGIN="LOGIN:PASSWORD"
YAMON_HOSTS_URL=https://YAMON_URL/hosts
YAMON_SERVICES_URL=https://YAMON_URL/services

YAMON_HOSTS_FILE=$(mktemp)
YAMON_SERVICES_FILE=$(mktemp)
CUR_DATE=$(date +'%F %H:%M:%S')
IFS=$'\n'

#Export nagios config
php /etc/nagios3/scripts/nagiosconf2xml.php > $CONFIG_FILE

#Get yamon host list
echo "search hosts"
curl -sk -u "$YAMON_LOGIN" $YAMON_HOSTS_URL.xml | xmlstarlet sel -T -t -m "//hosts/host" -v name -n|sort -u > $YAMON_HOSTS_FILE

#Add missing hosts/services to yamon
for s in $(xmlstarlet sel -T -t -m "//service" -v host_name -n $CONFIG_FILE |sort -u|grep -v "^$")
do
	grep -q "^$s$" $YAMON_HOSTS_FILE && continue #already here
	#curl -sk -u "$YAMON_LOGIN" -d "" $YAMON_HOSTS_URL
	echo "Add host [$s]"
	echo "insert into hosts (name, created_at, updated_at) values ('$s','$CUR_DATE','$CUR_DATE');" | mysql -uyamon -pyamon -Dyamon

done


#Get yamon services list
echo "search services"
curl -sk -u "$YAMON_LOGIN" $YAMON_SERVICES_URL.xml|xmlstarlet sel -T -t -m "//services/service" -v "host/name" -o ";" -v "host/id" -o ";" -v name -n|sort > $YAMON_SERVICES_FILE

for s in $(xmlstarlet sel -T -t -m "//service" -v host_name -o ';' -v service_description -n $CONFIG_FILE|sort -u|grep -v "^$")
do
	HOST=$(echo $s|cut -d';' -f1)
	SERVICE=$(echo $s|cut -d';' -f2)

	grep -q "^$HOST;[0-9]*;$SERVICE$" $YAMON_SERVICES_FILE && continue #already here
	
	HOST_ID=$(grep -m1 "^$HOST;.*" $YAMON_SERVICES_FILE | sed -e "s/^$HOST;//" -e "s/;.*//")

	echo "Add host=[$HOST]($HOST_ID), service=[$SERVICE]"

	echo "insert into services (name, host_id, created_at, updated_at) values ('$SERVICE',$HOST_ID,'$CUR_DATE','$CUR_DATE')" | mysql -uyamon -pyamon -Dyamon
done

rm -f $YAMON_HOSTS_FILE $YAMON_SERVICES_FILE
