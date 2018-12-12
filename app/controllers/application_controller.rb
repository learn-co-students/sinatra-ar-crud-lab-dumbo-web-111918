
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles/new' do
  	erb :new
  end

  post '/articles' do
  	@instance = Article.create(params)
  	@id = @instance.id
  	redirect "/articles/#{@id}"
  end

  get '/articles/:id' do
  	@article = Article.find(params[:id].to_i)
  	erb :show
  end

  get '/articles' do
  	@all = Article.all
  	erb :index
  end

  get '/articles/:id/edit' do
  	@id = params[:id].to_i
  	@article = Article.find(@id)
  	@title = @article.title
  	@content = @article.content
  	erb :edit
  end

  patch '/articles/:id' do
  	@id = params[:id].to_i
  	@article = Article.find(@id)
  	@article.update(title: params[:title], content: params[:content])
  	redirect "/articles/#{@id}"
  end

  delete '/articles/:id' do
  	@id = params[:id].to_i
  	Article.delete(@id)
  	redirect "/articles"
  end
end
