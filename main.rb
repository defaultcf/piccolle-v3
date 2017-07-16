require 'sinatra'
require 'sinatra/json'
require_relative "scrape"

set :bind, '0.0.0.0'
set :port, 8080
set :public_folder, File.dirname(__FILE__) + '/static'

get '/' do
    erb :index
end

get '/search' do
    s = Scrape.new
    json s.search(params['str'], params['n'].to_i)
end
