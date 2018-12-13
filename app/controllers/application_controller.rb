
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true
  end

  get "/" do
    erb :welcome
  end

#######################   INDEX   ############################
  get "/articles" do
    @articles = Article.all
    erb :"articles/index"
  end

  #######################   NEW   ############################
  get "/articles/new" do
    @article = Article.new
    erb :"articles/new"
  end

  #######################   CREATE   ############################
  post "/articles" do
    # binding.pry
    @article = Article.create(params[:article])
    redirect to "/articles/#{@article.id}"
  end

  #######################   SHOW   ############################
  get "/articles/:id" do
    find_article
    erb :"articles/show"
  end

  #######################   EDIT   ############################
  get "/articles/:id/edit" do
    find_article
    erb :"articles/edit"
  end

  #######################   UPDATE   ############################
  patch "/articles/:id" do
    find_article
    @article.update(params[:article])
    redirect to "/articles/#{@article.id}"
  end

  #######################   DELETE   ############################
  delete '/articles/:id' do
  find_article
    @article.destroy
    redirect to "/articles"
  end


  def find_article
    @article = Article.find(params[:id])
  end
end
