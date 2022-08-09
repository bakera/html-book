FILENAME=`git show -s --date=short --format="html-book_%cd_%ct.epub"`
pandoc ../epub_text/*.md -o $FILENAME --metadata-file=metadata.yaml --epub-cover-image=./cover.png
