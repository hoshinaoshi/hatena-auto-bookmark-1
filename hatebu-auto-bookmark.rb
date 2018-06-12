require "hatena-bookmark"
require "open-uri"
require "nokogiri"
require "date"
require "pry"
require "json"

creds = JSON.load(File.read("credentials.json"))

# %w(activerecord aws bootstrap css css3 database db design dev development docker font frontend git github html html5 javascript js linux macos mysql node.js npm postgresql programming qiita rails react ruby sql tech techfeed technology ubuntu ui ux vue vue.js web webdesign webpack webアプリケーション webデザイン web制作 エディタ エンジニア コンテナ サーバ システム デザイン データ フォント フロントエンド プログラミング 設計 開発)

arg = ARGV[0]
tags = # ブクマパターンを変えてカモフラージュ
  if arg == "adele"
    %w(bootstrap css css3 犬 かわいい 中国 design font frontend git github html 写真 出版 アイドル html5 javascript js node.js react ubuntu ui ux vue vue.js web webデザイン web制作 エディタ デザイン フォント フロントエンド)
  elsif arg == "oyasumi"
    %w(activerecord aws dev ラーメン development 歴史 docker git github 犯罪 linux 雑談 これはひどい ジェンダー mysql node.js npm programming qiita rails react ruby sql vue vue.js ネット webアプリケーション ネタ webデザイン web制作 エディタ エンジニア 大阪 東京 人生 コンテナ サーバ プログラミング 設計 開発)
  elsif arg == "rhodia"
    %w(database db カメラ design dev development docker オカルト frontend git github html html5 お金 javascript js linux macos qiita tech techfeed technology ubuntu ui ux vue vue.js web webdesign webpack webアプリケーション 海外 webデザイン web制作 エディタ エンジニア コンテナ サーバ システム コーヒー デザイン フロントエンド プログラミング 設計 開発)
  end

tags.each do |tag|
  p "Starting to get: " + tag
  url = URI.encode "http://b.hatena.ne.jp/search/tag?safe=on&q=#{tag}&users=20"
  # タグ1つあたり平均1件ほどブクマされるように絞り込み

  html = open(
    url,
    {"User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36"}
    # はてブのページはUserAgentを偽装しないと取得できない
    ) do |f|
    charset = f.charset
    f.read
    # 文字化け回避
  end

  doc = Nokogiri::HTML.parse(html, nil, nil)

  hatebu = Hatena::Bookmark.new(
    consumer_key:    creds[arg]["consumer_key"],
    consumer_secret: creds[arg]["consumer_secret"],
    request_token:   creds[arg]["Access token"],
    request_secret:  creds[arg]["Access token secret"]
  )

  for num in 0..9 # タグ1つあたりの新着記事は多くの場合せいぜい3件程度であるため
    created_at = doc.css(".entry-contents-date")[num].inner_text.gsub(" ", "")
    latest_provisional = Date.today - 1
    latest = latest_provisional.to_s.gsub("-","/")

    if created_at == latest
      # 今日のエントリーを取得しても今日中にまた更新される可能性があるため、前日更新のエントリーをブクマする
      hatebu.create(url: doc.css(".bookmark-item h3 a")[num][:href])
      p "Bookmarked: " + doc.css(".bookmark-item h3 a")[num][:href]
    else
      puts "Not Bookmarked: " + doc.css(".bookmark-item h3 a")[num][:href]
    end

    sleep(rand(10))
  end

end
