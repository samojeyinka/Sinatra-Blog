require 'sinatra'
require 'sinatra/activerecord'

set :database, { adapter: "sqlite3", database: "blog.sqlite3" }

class Post < ActiveRecord::Base
end

get '/' do
  @posts = Post.all
  erb :index
end

get '/posts/new' do
  erb :new
end

post '/posts' do
  @post = Post.new(params[:post])
  if @post.save
    redirect '/'
  else
    erb :new
  end
end

get '/posts/:id' do
  @post = Post.find(params[:id])
  erb :show
end

get '/posts/:id/edit' do
  @post = Post.find(params[:id])
  erb :edit
end

patch '/posts/:id' do
  @post = Post.find(params[:id])
  if @post.update(params[:post])
    redirect "/posts/#{@post.id}"
  else
    erb :edit
  end
end

delete '/posts/:id' do
  @post = Post.find(params[:id])
  @post.destroy
  redirect '/'
end
