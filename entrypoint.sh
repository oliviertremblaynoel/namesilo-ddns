#!/bin/sh
LASTCHANGEFILE=/data/lastchange
PREVIOUSIPFILE=/data/previousip
PREVIOUSIP=$(cat $PREVIOUSIPFILE)
CURRENTIP=$(curl -s https://ifconfig.co/ip)
NOW=$(date +"%Y-%m-%d %Hh%M")
HOST="*"
echo "${NOW} ${PREVIOUSIP} -> ${CURRENTIP}"
echo "$(cat $LASTCHANGEFILE) (Last change)"

# Fetch the DNS records
RECORDS=$(curl -s "https://www.namesilo.com/api/dnsListRecords?version=1&type=xml&key=$NAMESILO_TOKEN&domain=$DOMAIN")

# Extract record IDs dynamically using xmlstarlet
ROOT_RECORD_ID=$(echo "$RECORDS" | xmlstarlet sel -t -m "//resource_record[host='$DOMAIN']" -v "record_id")
WILDCARD_RECORD_ID=$(echo "$RECORDS" | xmlstarlet sel -t -m "//resource_record[host='$HOST.$DOMAIN']" -v "record_id")

if [ "$PREVIOUSIP" != "$CURRENTIP" ]; then
    curl "https://www.namesilo.com/api/dnsUpdateRecord?version=1&type=xml&key=$NAMESILO_TOKEN&domain=$DOMAIN&rrid=$ROOT_RECORD_ID&rrvalue=$CURRENTIP&rrttl=3600" > /dev/null # Update the root record

    curl "https://www.namesilo.com/api/dnsUpdateRecord?version=1&type=xml&key=$NAMESILO_TOKEN&domain=$DOMAIN&rrid=$WILDCARD_RECORD_ID&rrhost=$HOST&rrvalue=$CURRENTIP&rrttl=3600" > /dev/null # Update the wildcard record

    # Store change
    echo "$CURRENTIP" > $PREVIOUSIPFILE
    echo "$NOW $PREVIOUSIP -> $CURRENTIP" > "$LASTCHANGEFILE"
    echo "$(cat $LASTCHANGEFILE) (New change)"
fi
