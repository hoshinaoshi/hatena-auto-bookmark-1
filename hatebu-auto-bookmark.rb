# 使用しない

require "hatena-bookmark"
require "open-uri"
require "nokogiri"
require "date"

tags = %w(activerecord aws bootstrap css css3 database db design dev development docker font frontend git github html html5 javascript js linux macos mysql node.js npm postgresql programming qiita rails react ruby sql tech techfeed technology ubuntu ui ux vue vue.js web webdesign webpack webアプリケーション webデザイン web制作 エディタ エンジニア コンテナ サーバ システム デザイン データ フォント フロントエンド プログラミング 設計 開発)

tags.each do |tag|
  p "Starting to get: " + tag
  url = URI.encode "http://b.hatena.ne.jp/search/tag?safe=on&q=#{tag}&users=3"
  # タグ1つあたり平均1件ほどブクマされるように絞り込み

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
