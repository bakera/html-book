EPUBをいい感じに処理するシェルスクリプト群
基本的に以下を以下の順に実行すればよい

./tohml.sh : MarkdownをPandocによってXHTMLに変換する
./uuid.sh : OPFファイル内のUUIDを書き換える
./epub-gemerate.sh : リソースをZIP化してEPUBを作成し epubcheck を実行する

