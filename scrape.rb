require 'nokogiri'
require 'open-uri'
require 'kconv'

class Scrape
    def getimg(url)
        html = open(url, 'r:binary').read
        doc = Nokogiri::HTML(html.toutf8, nil, 'utf-8')
        imgs = []
        doc.xpath('//dd').each do |node|
            img = node.text.scan(/ttp:\/\/\S+\.(?:jpg|png)/)
            imgs += img
        end
        return imgs
    end
end

# url = 'http://toro.2ch.sc/test/read.cgi/anime/1498731005/0-'
#
# s = Scrape.new
# imgs = s.getimg(url)
# p imgs
