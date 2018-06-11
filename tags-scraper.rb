require "open-uri"
require "nokogiri"
require "csv"

CSV.open("tags.csv", "w") do |csv|

  url = "http://b.hatena.ne.jp/t"
  option = {
    "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36"
  }
  charset = nil
  html = open(url,option) do |f|
      charset = f.charset
      f.read
  end
  doc = Nokogiri::HTML.parse(html,nil,charset)
  doc.css("#taglist li a").each do |a|
      tag = a.inner_text
      removedast = tag.gsub("*","")
      formatted = removedast.gsub(" ", "")
      p formatted
      csv << [formatted]
      sleep(1)
  end
end
