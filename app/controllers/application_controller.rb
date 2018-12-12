
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
# Create ---------------------------
  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    inst = Article.create(params)
    redirect "/articles/#{inst.id}"
  end

# Read -----------------------------
  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/:id' do
    @article = Article.find(params[:id].to_i)
    erb :show
  end
# Update ----------------------------
  get '/articles/:id/edit' do
    @id = params[:id].to_i
    erb :edit
  end

  patch '/articles/:id' do
    inst = Article.find(params[:id])
    inst.update(title: params[:title], content: params[:content])
    # binding.pry
    redirect "/articles/#{params[:id]}"
  end

  delete '/articles/:id' do
    Article.delete(params[:id])
    redirect "/articles"
  end

end
