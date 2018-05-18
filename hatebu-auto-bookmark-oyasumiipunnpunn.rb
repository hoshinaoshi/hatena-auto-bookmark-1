require "hatena-bookmark"
require "open-uri"
require "nokogiri"
require "date"

# サーバサイド 敢えてノイズ入れる

tags = %w(activerecord aws dev ラーメン development 歴史 docker git github 犯罪 linux 雑談 これはひどい ジェンダー mysql node.js npm programming qiita rails react ruby sql vue vue.js ネット webアプリケーション ネタ webデザイン web制作 エディタ エンジニア 大阪 東京 人生 コンテナ サーバ プログラミング 設計 開発)

tags.each do |tag|
  p "Starting to get: " + tag
  url = URI.encode "http://b.hatena.ne.jp/search/tag?safe=on&q=#{tag}"
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
    consumer_key:    ARGV[0],
    consumer_secret: ARGV[1],
    request_token:   ARGV[2],
    request_secret:  ARGV[3]
  )

  for num in 0..9 # タグ1つあたりの新着記事は多くの場合せいぜい3件程度であるため
    created_at = doc.css(".search-result blockquote .created")[num].inner_text.gsub(" ", "")
    latest_provisional = Date.today - 1
    latest = latest_provisional.to_s.gsub("-","/")

    if created_at == latest
        # 今日のエントリーを取得しても今日中にまた更新される可能性があるため、前日更新のエントリーをブクマする
        hatebu.create(url: doc.css(".search-result h3 a")[num][:href])
        p "Bookmarked: " + doc.css(".search-result h3 a")[num][:href]
    else
      puts "Not Bookmarked: " + doc.css(".search-result h3 a")[num][:href]
    end

    sleep(rand(10))
  end

end
