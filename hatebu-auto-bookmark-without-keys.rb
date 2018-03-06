require "hatena-bookmark"
require "open-uri"
require "nokogiri"

tags = %w(css)
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
