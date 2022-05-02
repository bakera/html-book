cd epub/root
FILENAME=`git show -s --date=short --format="../html_kaitai_%cd_%ct.epub"`
if [ -e $FILENAME ]; then
  rm $FILENAME
fi
zip -0 -X $FILENAME mimetype
zip -r $FILENAME * -x mimetype -x "*.DS_Store"

# java -jar ../../epubcheck-4.2.6/epubcheck.jar $FILENAME