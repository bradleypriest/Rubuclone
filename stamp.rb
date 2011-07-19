require 'sinatra'
require 'haml'
require 'stamp'
require 'sass'

set :haml, :format => :html5

get '/' do
  haml :index
end

post '/' do
  @stamp = Stamp.strftime_format(params[:time])
  haml :index
end

get '/style.css' do
  scss :style
end

configure :development do
  require 'coffee-script'
  get '/application.js' do
    coffee :application
  end
end