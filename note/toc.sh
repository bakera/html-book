grep "^#" ../md_text/*.md | sed -e 's/^\.\.\/md_text\///' | sed -e 's/\.md//'
