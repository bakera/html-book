for pathname in ../epub_text/*.md
do
  echo $pathname
  MarkdownFileName="${pathname##*/}"
  HtmlFileName="${MarkdownFileName%.*}.xhtml"
  pandoc $pathname --standalone --template=template.html \
    | sed 's/role="doc-noteref"/role="doc-noteref" epub:type="noteref"/g' \
    > "./epub/root/item/xhtml/$HtmlFileName"
done
