
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true
  end

  get '/' do
    redirect to "/articles"
  end

  get "/articles" do
      @articles = Article.all
      erb :index
  end

  get '/articles/new' do 
    erb :new
  end
  
  post '/articles' do 
    #capture the new input params and save the params
     #below works with properly formatted params in HTML form
    #  binding.pry
    @article = Article.new(params[:article]) #create new article
    @article.save
    redirect to "/articles/#{@article.id}"
    end

  get "/articles/:id" do
    #show root
      @article = Article.find(params[:id])
      erb :show
  end

  get "/articles/:id/edit" do 
    @article= Article.find(params[:id])
    erb :edit
  end

    patch "/articles/:id" do
    @article= Article.find(params[:id])
    @article.update(params[:article])
    redirect to ("/articles/#{@article.id}")
    end

    #how to delete article from database 
    delete "/articles/:id" do
    @article= Article.find(params[:id])
    @article.destroy
    redirect to ("/articles")
    end

end
