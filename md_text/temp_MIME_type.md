# MIMEタイプ

MIMEタイプ[^1]とは、RFC 2046[^2]で定義される「インターネットメディアタイプ」（internet media type）を表すものです。MIMEタイプはIANAが公式のものを管理しており、登録されているMIMEタイプはMedia Typesのページで見ることができます[^3]。ただしメディアタイプという名称は、MIME sniffing Standardでも指摘されているように（MIME sniffingについては後述します）、CSSのメディアクエリーで記述されるメディアタイプと同じであり、これと混同してしまうことがあります[^4]。そのため、本書でもMIMEタイプと呼ぶことにします。

MIMEタイプは、「タイプ」（type）と「サブタイプ」（subtype）、オプションで「パラメーター」（parameter）で構成されます。タイプとサブタイプの間は"/"（スラッシュ）で結合し、もしパラメーターがあれば、サブタイプとパラメーターの間を";"（セミコロン）で結合します[^5]。具体的な例としては、以下のような形式になります。

```txt
image/png
text/html;charset=utf-8
```

タイプは全般的なデータの分類を示すものとされます。例えば、`image`（画像）や`text`（テキスト）です。ほかにも`application`や`audio`、`font`、`video`あるいは`multipart`といったものがあります。

サブタイプはタイプの細かな分類であり、実際のファイル形式に相当します。`image/png`であれば、`png`が該当するものです。MIMEタイプ`image/png`でPNG画像形式であることが表されます。

パラメーターは「名前」と「値」を"="（等号）で結合したものです。`text/html;charset=utf-8`であれば`charset=utf-8`がこれに当たります。この場合、文字エンコーディングがUTF-8であることを示しています[^6]。

MIMEタイプは、ファイルシステムの拡張子に似た概念であり、ファイルの種類を表すものです。その一方で、実際のファイル形式とMIMEタイプは、1対1の対応関係にはありません。同じ形式に複数のMIMEタイプを割り当てるのは奨められていませんが、実際には数多くあります。例えば、XMLのMIMEタイプには`text/xml`や`application/xml`があります。

[^1]: MIME（マイムと発音）とは、Multipurpose Internet Mail Extensionsの略称です。MIME自身は電子メールでASCII英数字以外のデータ（漢字などの各国語の文字や、添付ファイルなど）を扱うための拡張仕様です。

[^2]: <https://datatracker.ietf.org/doc/html/rfc2046>

[^3]: <https://www.iana.org/assignments/media-types/media-types.xhtml>

[^4]: <https://mimesniff.spec.whatwg.org/#mime-type>

[^5]: MIME sniffing Standardが参照するRFC 7231の`media-type`の構文では、セミコロンの前後に空白があってもよいと定義されています。<https://datatracker.ietf.org/doc/html/rfc7231#section-3.1.1.1>

[^6]: charは、characterの略としてIT業界でよく用いられてきたジャーゴンです。charsetをそのまま解釈すれば文字集合を表しますが、charsetの値は文字エンコーディングです。歴史的にUnicodeが普及する前にはさまざまな文字集合が存在したこと、そして文字集合と文字エンコーディングが混同されてきた名残とも解釈できます。

## サブタイプのパターン

サブタイプにはいくつかの形式が定められており、現在はRFC 6838[^7]で整理されています。

サブタイプは、サブタイプは"`.`"（ピリオド）を区切り文字とする階層構造を持つことができ、これを「ツリー」（tree）と呼びます。以下にいくつかのサブタイプの例を挙げてみます。

```txt
image/png
image/vnd.microsoft.icon
text/x-javascript
image/svg+xml
```

ピリオドを持たないサブタイプは「標準ツリー」（standard tree）と呼ばれます。先に挙げた`image/png`であれば、`png`が該当します。

`image/vnd.microsoft.icon`のように、サブタイプの先頭に`vnd.`という接頭辞がついていることがあります。接頭辞として`vnd.`を持つものは「ベンダーツリー」（vender tree）と呼ばれ、これはベンダー固有のファイルを登録するものです。

`text/x-javascript`のように、サブタイプが`x-`で始まるものは、以前は私的利用のために予約されていたものです。現在では特別な扱いをするものでなく、`x-`で始まるものもIANAに登録されています。RFC 6838では`x-`に代わって`x.`が予約されています。

`image/svg+xml`の`+xml`ように、サブタイプの末尾に`+`で始まる接尾辞がついていることがあります。これは、Structured Syntax Suffixと呼ばれるもので、サブタイプの一般的なファイルの種類を形式的に表すものです。現在ではRFC 6839[^8]で用法が明確化・定義されています。

[^7]: 3. Registration Trees and Subtype Names <https://datatracker.ietf.org/doc/html/rfc6838#section-3>

[^8]: <https://datatracker.ietf.org/doc/html/rfc6839>

## MIME sniffing

MIME sniffing（MIMEスニッフィング）は、MIMEタイプが欠落している、またはMIMEタイプが誤って設定されているとブラウザーが判断した場合に、ブラウザーがファイルの内容を見て、MIMEタイプを決定するものです。

歴史的に、古い一部のブラウザーは、サーバーが送信する`Content-Type`ヘッダーを一部無視してsniffingをし、他のブラウザーを異なる解釈をすることがありました。これにより、セキュリティ上の問題を引き起こすことがありました。その一方で誤った`Content-Type`ヘッダーを送信するサーバーも広く存在しています。

各ウェブブラウザーが独自に異なるMIME sniffingを行い、標準仕様が存在しない状況では、サーバー側でセキュリティの問題を回避するための十分な対策を施すのが困難な状態でした。そこで紆余曲折を経てブラウザー側でのMIME sniffingの挙動を整理したものがMIME sniffing Standardとなります。

なお、サーバーは`X-Content-Type-Options`ヘッダーを送信することによりで、MIME sniffingを抑制できます。
