#!/bin/bash

sed -i 's|${HOSTNAME}|'"$HOSTNAME"'|' /webapp/tomcat/conf/server.xml
sed -i 's|${DOC_BASE}|'"$DOC_BASE"'|' /webapp/tomcat/conf/server.xml

sed -i 's|${HOSTNAME}|'"$HOSTNAME"'|' /webapp/conf.txt
sed -i 's|${DB_HOSTNAME}|'"$DB_HOSTNAME"'|' /webapp/conf.txt
sed -i 's|${DB_SCHEMA}|'"$DB_SCHEMA"'|' /webapp/conf.txt
sed -i 's|${DB_USERNAME}|'"$DB_USERNAME"'|' /webapp/conf.txt
sed -i 's|${DB_PASSWORD}|'"$DB_PASSWORD"'|' /webapp/conf.txt

echo "Done"

sleep 100000
