for pathname in ../epub_text/*.md
do
  echo $pathname
  MarkdownFileName="${pathname##*/}"
  HtmlFileName="${MarkdownFileName%.*}.xhtml"
  pandoc $pathname --standalone --template=template.html \
    | sed 's/<!DOCTYPE html>/<\?xml version="1.0" encoding="UTF-8"\?>\n<!DOCTYPE html>/g' \
    | sed 's/<meta charset="utf-8" \/>/<meta http-equiv="content-type" content="text\/html; charset=utf-8" \/>/g' \
    | sed 's/role="doc-noteref"/role="doc-noteref" epub:type="noteref"/g' \
    | sed 's/\[\([0-9][0-9]*\)\]/<span class="fignumber"><span class="paren">[<\/span>\1<span class="paren">]<\/span><\/span>/g' \
    | sed 's/<\/figcaption>/<\/figcaption>\n<div class="figbody">/g' \
    | sed 's/<\/figure>/<\/div>\n<\/figure>/g' \
    | sed 's/>↩︎</><br\/>(本文へ)</g' \
    | sed 's/إيان/<img src="..\/image\/arabian.png" alt="إيان" class="gryph" \/>/g' \
    > "./epub/root/item/xhtml/$HtmlFileName"
done
