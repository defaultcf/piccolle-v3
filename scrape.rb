require 'nokogiri'
require 'uri'
require 'open-uri'
require 'kconv'

class Scrape
    def search(str)
        url = 'http://find.2ch.sc/?STR=' + str.gsub(/\s/, '+')
        html = open(url, 'r:binary').read
        doc = Nokogiri::HTML(html.toutf8, nil, 'utf-8')
        doc.xpath('//dt').each do |node|
            a = node.css('a')
            if !a.empty? then
                thre = a.attribute('href').value.to_s
                p getimg(thre)
            end
        end
    end

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
