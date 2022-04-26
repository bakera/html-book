for pathname in ../epub_text/*.md
do
  echo $pathname
  MarkdownFileName="${pathname##*/}"
  HtmlFileName="${MarkdownFileName%.*}.html"
  pandoc $pathname -o "result/html/$HtmlFileName" --standalone
done