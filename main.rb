require 'sinatra'
require_relative "scrape"

set :bind, '0.0.0.0'
set :port, 8080

get '/search' do
    s = Scrape.new
    s.search(params['str'], params['n'].to_i).to_s
end
