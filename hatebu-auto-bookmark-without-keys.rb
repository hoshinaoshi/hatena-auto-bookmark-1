require "hatena-bookmark"
require "open-uri"
require "nokogiri"

tags = %w(web プログラミング activerecord ai android api app ar aws bash batch bootstrap c# c++ chrome css dart database db deeplearning design development docker electron font frontend gcp git github go golang html html5 http https ibm ios java javascript jquery js json jvm kubernetes laravel linux monitoring mysql node.js performance php postgresql programming python qiita rails raspberrypi rds react ruby rust scala selenium sql ssl swift tcp tech techfeed technology typescript ubuntu ui uml unity ux vagrant virtualbox vmware vr vue vue.js webdesign webpack webアプリケーション webデザイン web制作 xcode エディタ エンジニア コンテナ サーバ システム ディープラーニング デザイン データ ドメイン フォント フリーソフト フロントエンド プラグイン プログラミング ライブラリ 人工知能 機械学習 深層学習 素材 設計 開発)

tags.each do |tag|
  url = "http://b.hatena.ne.jp/search/tag?safe=on&q=#{tag}&users=50"
  option = {
    "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36"
  }

  html = open(url, option) do |f|
    charset = f.charset
    f.read
  end

  doc = Nokogiri::HTML.parse(html, nil, nil)
  doc.css(".search-result h3 a").each do |a|
    url = a[:href]
    p url

    hatebu = Hatena::Bookmark.new(
      consumer_key:    "取得",
      consumer_secret: "取得",
      request_token:   "取得",
      request_secret:  "取得"
    )

    hatebu.create(:url => url)
    sleep(rand(100))
  end
end
