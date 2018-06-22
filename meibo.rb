# coding: utf-8
require 'active_record'
require 'sinatra'
require 'sinatra/reloader'
require 'haml'

ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection(:development) #シンボルにしないと動かないらしい.ruby5.0.0以降

class Member < ActiveRecord::Base
end

get '/' do
  @members = Member.all
  haml :index
end

post '/new' do
  member = Member.new
  member.id = params[:id]
  member.name = params[:name]
  member.save
  redirect '/'
end

delete '/del' do
  member = Member.find(params[:id])
  member.destroy
  redirect '/'
end

get '/modify1' do
  @member = Member.find(params[:id])
  haml :modify
end

post '/modify2' do
  member = Member.find(params[:id])
  member.update_attribute(:name,  params[:new_name])
  member.save
  redirect '/'  
end
