require "hatena-bookmark"
require "open-uri"
require "nokogiri"

for path in 0..9 do
    multipled_path = path * 40
    tag = "css"
    url = "http://b.hatena.ne.jp/search/tag?safe=on&q=#{tag}&of=#{multipled_path}"
    opt = {}
    opt['User-Agent'] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/XXXXXXXXXXXXX Safari/XXXXXX Vivaldi/XXXXXXXXXX' # user agent
    charset = nil

    html = open(url,opt) do |f|
        charset = f.charset
        f.read
    end

    doc = Nokogiri::HTML.parse(html,nil,charset)
    doc.css(".search-result h3 a").each do |a|
        url = a[:href]
        p url
        sleep(1)

        hatebu = Hatena::Bookmark.new(
          consumer_key:    '取得',
          consumer_secret: '取得',
          request_token:   '取得',  #access_token
          request_secret:  '取得'  #access_token_secret
        )

        hatebu.create(:url => url)
    end

end
