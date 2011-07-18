require 'sinatra'
require 'haml'
require 'stamp'
require 'sass'
require 'coffee-script'

set :haml, :format => :html5

get '/' do
  haml :index
end

post '/convert' do
  @stamp = Stamp.strftime_format(params[:time])
  haml :index
end

get '/style.css' do
  scss :style
end

get '/application.js' do
  coffee :application
end