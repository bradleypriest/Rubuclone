require 'sinatra'
require 'haml'
require 'stamp'
require 'sass'

set :haml, :format => :html5

def any(url, verbs = %w(get post put delete), &block)
  verbs.each do |verb|
    send(verb, url, &block)
  end
end

any '/' do
  @stamp = Stamp.strftime_format(params[:time]) if params[:time]
  haml :index
end

post '/convert.json' do
  response['Content-Type'] = 'application/json'
  "{\"stamp\": \"#{Stamp.strftime_format(params[:time])}\", \"time\":\"#{params[:time]}\"}"
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