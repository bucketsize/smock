require 'sinatra'
require 'pp'
require 'session_helper'
require 'app'
require 'json'

use Rack::Session::Pool, :expire_after => 2592000

helpers SessionHelper, App

# routing schemes

# sets an overide to the next mockset
get '/mock/setoveride/:service/:stage' do
  set_overide params[:service], params[:stage]
  "done"
end

# disable an overide previously set
get '/mock/unsetoveride/:service' do
  forget_overide params[:service]
  "done"
end

get '/mock/services' do
  files=Dir[SERVICES_PATH+'/*']
  h={}
  files.each {|f| 
    s=File.basename(f).split(/_/)
    h[s[0]] = [] if  h[s[0]].nil?
    h[s[0]] << s[1].split(/\./)[0]
  }
  pp h
  remember_as 'services', h
  h.extend JSON 
  h.to_json
end

# sets what to mock for the next service call
get '/mock/:service/:stage' do
  dispatch_service params[:service], params[:stage]
end

# web admin interface
get '/mock/admin' do
  erb :admin
end
