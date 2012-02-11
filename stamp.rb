require 'sinatra'
require 'haml'
require 'sass'
require './parser'

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
  process_regex
  response['Content-Type'] = 'application/json'
  "{\"result\":\"#{escape_javascript(@result)}\",\"matches\":\"#{escape_javascript(@matches.to_s)}\"}"
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
    "'"     => "\\'"
  }

  def process_regex
    if params[:regex]
      parser = Parser.new(params[:regex], params[:string])
      @result = parser.highlight
      @matches = parser.matches
    end
  end

  def escape_javascript(javascript)
    result = javascript.gsub(/(\\|<\/|\r\n|[\n\r"'])/) {|match| JS_ESCAPE_MAP[match] }
  end