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
  process_regex
  haml :index
end

post '/convert.json' do
  puts params
  process_regex
  response['Content-Type'] = 'application/json'
  "{\"result\":\"#{escape_javascript(@result)}\"}"
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


private
  JS_ESCAPE_MAP = {
          '\\'    => '\\\\',
          '</'    => '<\/',
          "\r\n"  => '\n',
          "\n"    => '\n',
          "\r"    => '\n',
          '"'     => '\\"',
          "'"     => "\\'" }

  def process_regex
    if params[:regex]
      regex = Regexp.new("("+params[:regex]+")")
      @result = params[:string].gsub regex do
        "<span class=\"highlight\">#{$1}</span>"
      end
    end
  end

  def escape_javascript(javascript)
    result = javascript.gsub(/(\\|<\/|\r\n|[\n\r"'])/) {|match| JS_ESCAPE_MAP[match] }
  end