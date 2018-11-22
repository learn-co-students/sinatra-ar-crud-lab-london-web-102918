
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  #index
  # get '/' do
  #   erb :index
  # end

  #index
  get '/posts' do
    @posts = Post.all
    erb :index
  end
  #new
  get "/posts/new" do
    erb :new
    # binding.pry
  end
  #create
  post "/posts" do

    new_post = Post.create(name: params["name"], content: params["content"])
    # redirect "/posts/#{new_post.id}"
    redirect "/posts"
  end

  #show
  #why do we have access to a params hash here?!
  #need to do this after new otherwise will think that is an iD
  get "/posts/:id" do
    @selected_post = Post.find(params[:id])
    erb :show
  end

  #edit

  get '/posts/:id/edit' do
    @selected_post_for_edit = Post.find(params[:id])
    erb :edit
  end

  #update

  patch "/posts/:id" do
    selected_post_for_update = Post.find(params[:id])
    selected_post_for_update.update(name: params["name"], content: params["content"])
    redirect "/posts/#{selected_post_for_update.id}"
  end

  #delete

  delete '/posts/:id/delete' do
    selected_post_for_destruction = Post.find(params[:id])
    selected_post_for_destruction.destroy
    redirect "/posts"
    #delete
  end


  #made a return route
  post "/return" do
    redirect "/posts"
  end

  #made a re-edit route
  post "/posts/:id/re_edit" do
    selected_post_for_re_edit = Post.find(params[:id])
    redirect "/posts/#{selected_post_for_re_edit.id}/edit"
  end

end
