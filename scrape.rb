require 'nokogiri'
require 'uri'
require 'open-uri'
require 'kconv'

class Scrape
    def search(str)
        url = 'http://find.2ch.sc/?STR=' + str.gsub(/\s/, '+')
        begin
            doc = open_html(url)
        rescue => e
            p e
            return
        end
        imgs = []
        doc.xpath('//dt').each do |node|
            a = node.css('a')
            if !a.empty? then
                thre = a.attribute('href').value.to_s
                imgs += getimg(thre)
                sleep(1)
            end
        end
        return imgs
    end

    def getimg(url)
        begin
            doc = open_html(url)
        rescue => e
            p e
            p url
            return []
        end
        imgs = []
        doc.xpath('//dd').each do |node|
            img = node.text.scan(/ttp:\/\/\S+\.(?:jpg|png)/)
            imgs += img
        end
        return imgs
    end

    private
    def open_html(url)
        html = open(url, 'r:binary').read
        return Nokogiri::HTML(html.toutf8, nil, 'utf-8')
    end
end
