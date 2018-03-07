require "hatena-bookmark"
require "open-uri"
require "nokogiri"
require "date"

tags = %w(activerecord agile ai android api app ar aws bash batch bootstrap c# c++ cakephp ci chrome css css3 dart database db deeplearning design dev development dns docker electron font frontend gas gcp git github go golang haskell html html5 http https ibm ide ios java javascript jquery js json jvm kubernetes laravel linux machinelearning macos monitoring mysql node.js npm nuxt.js oracle oss performance php postgresql programming python qiita rails raspberrypi rds react ruby rust scala selenium shell sql ssl swift tcp tech techfeed technology tensorflow typescript ubuntu ui uml unity ux vagrant virtualbox vmware vr vue vue.js web webdesign webpack xcode webアプリケーション webデザイン web制作 エディタ エンジニア コンテナ サーバ システム ディープラーニング デザイン データ ドメイン フォント フリーソフト フロントエンド プラグイン プログラミング ライブラリ 人工知能 機械学習 深層学習 素材 設計 開発)

tags.each do |tag|
  url = URI.encode "http://b.hatena.ne.jp/search/tag?safe=on&q=#{tag}&users=50"
  option = {
    "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36"
  }

  html = open(url, option) do |f|
    charset = f.charset
    f.read
  end

  doc = Nokogiri::HTML.parse(html, nil, nil)
  doc.css(".search-result blockquote .created").each do |day|
    doc.css(".search-result h3 a").each do |a|
      url = a[:href]

      hatebu = Hatena::Bookmark.new(
        #keys
      )

      today = Date.today.to_s.gsub("-","/")

      if day = today
          hatebu.create(:url => url)
          p "bookmarked: " + url + " today is " +day
      end

      sleep(rand(100))

    end
  end
end
