
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    @articles= Article.all
erb :index
  end



  get '/articles/new' do
    @article = Article.new

    erb :new

  end
  get '/articles' do
    @articles = Article.all
  #  binding.pry
    erb :index
  end

  post "/articles" do
  @article = Article.create(params)
  redirect to "/articles/#{@article.id}"
    #binding.pry
end

get "/articles/:id" do
  find_article
erb :show
end

get '/articles/:id/edit' do
  @article = Article.find(params[:id])
  #binding.pry
  erb :edit
end

patch '/articles/:id' do
  #binding.pry
  find_article
  # binding.pry
    @article.update(title: params[:title], content: params[:content])
    redirect to "/articles/#{@article.id}"
  end

  get "/articles/delete" do

    erb :delete
  end

  delete "/articles/:id" do
    find_article
    @article.destroy
    redirect to "/articles"
  end


def find_article
#  binding.pry
  @article = Article.find(params[:id])
end
end
