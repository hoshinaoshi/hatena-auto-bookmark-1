require "open-uri"
require "nokogiri"

for path in 0..9 do
    multipled_path = path * 40
    tag = "css"
    url = "http://b.hatena.ne.jp/search/tag?safe=on&q=#{tag}&of=#{multipled_path}"
    # url = "http://b.hatena.ne.jp/"
    opt = {}
    opt['User-Agent'] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/XXXXXXXXXXXXX Safari/XXXXXX Vivaldi/XXXXXXXXXX'
    # user agent
    charset = nil
    html = open(url,opt) do |f|
        charset = f.charset
        f.read
    end
    doc = Nokogiri::HTML.parse(html,nil,charset)
    doc.css(".search-result h3 a").each do |kw|
        kws = kw[:href]
        p kws
        sleep(1)
    end
end
