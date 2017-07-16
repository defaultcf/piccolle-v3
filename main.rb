require 'sinatra'
require_relative "scrape"

set :bind, '0.0.0.0'
set :port, 8080

get '/' do
    s = Scrape.new
    s.search('new game').to_s
end
