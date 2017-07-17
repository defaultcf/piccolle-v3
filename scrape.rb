require 'nokogiri'
require 'uri'
require 'open-uri'
require 'kconv'

class Scrape
    def search(str, n)
        s_a = str.split(/\s+/).map{|s| URI.encode(s.toeuc)}
        s = s_a.join('+')
        url = 'http://find.2ch.sc/?STR=' + s
        begin
            doc = open_html(url)
        rescue => e
            p e
            return []
        end

        imgs = []
        if n > 0 then
            nodes = doc.xpath("//dt[#{n}]")
        else
            nodes = doc.xpath("//dt")
        end

        for node in nodes do
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
            img.map!{|i| {:src => 'h' + i}}
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
