require_relative "scrape"

url = "http://toro.2ch.sc/test/read.cgi/anime/1498731005/0-"

s = Scrape.new
print s.getimg(url)
