UUID=`uuidgen`
echo $UUID
sed -i '' -e "s/urn:uuid:[-0-9A-Z]*/urn:uuid:${UUID}/g" epub/root/item/standard.opf
