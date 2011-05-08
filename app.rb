require 'rubygems'
require 'sinatra'

require 'haml'
require 'sass'
require 'redcarpet'

require 'json'

###################################################
# Stylesheet
###################################################

get '/css/:stylesheet.css' do
  # Renders ./views/(stylesheet).sass
  content_type 'text/css', :charset => 'utf-8'
  sass ("css/"+params[:stylesheet]).to_sym
end

###################################################
# App
###################################################

get '/' do
  json = File.open('test.json').gets
  data = JSON.parse(json)
  haml :vroc, :locals => {:data => data}
end