for pathname in ../epub_text/*.md
do
  echo $pathname
  MarkdownFileName="${pathname##*/}"
  HtmlFileName="${MarkdownFileName%.*}.xhtml"
  pandoc $pathname -o "./epub/root/item/xhtml/$HtmlFileName" --standalone --template=template.html
done