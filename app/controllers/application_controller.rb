
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    @posts = Post.all
    erb :posts
    erb :index
  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    @post = Post.create(name: params[:name], content: params[:content])
    @post.update
    erb :posts
  end

  get '/posts' do
    @posts = Post.all
    erb :posts
  end

  get '/posts/:id' do
    @post = Post.find_by_id(params[:id])
    erb :show
  end

  get "/posts/:id/edit" do
    @post = Post.find_by_id(params[:id])
    erb :edit
  end

  patch "/posts/:id" do
    post = Post.find_by_id(params[:id])
    post.update(name: params[:name], content: params[:content])
    redirect to "/posts/#{post.id}"
  end

  delete "/posts/:id/delete" do
    post = Post.find_by_id(params[:id])
    post.destroy
    redirect "/posts"
  end

end
