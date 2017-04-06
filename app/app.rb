ENV['RACK_ENV'] ||= "development"
require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'sinatra/flash'

class BookmarkManager < Sinatra::Base
  enable :sessions
  set :session_secret, 'top secret data'
  register Sinatra::Flash

  get '/' do
    @user = User.new
    erb :sign_up
  end

  post '/create_user' do
      session[:fail] = false
      @user = User.new(email: params[:email], password: params[:password], confirm_password: params[:confirm_password])
      if @user.save
        session[:user_id] = @user.id
        redirect '/links'
      else
        flash.now[:notice] = @user.errors.full_messages
        erb :sign_up
      end
  end

  get '/sign_in' do
    erb :'sign_in'
  end

  post '/return_user' do
    # require 'pry'; binding.pry
    user = User.first(:email => params[:email])
    session[:user_id] = user.id
    redirect '/links'
  end

  get '/links' do # The path / url.
    @links = Link.all # Set instance variable to Link all.
    erb :'links/index' # Reference the file.
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.new(url: params[:url], title: params[:title])
    tag_names = params[:tags].split(', ')
    tag_names.each do |tag_name|
      link.tags << Tag.first_or_create(name: tag_name)
    end
    link.save
    redirect '/links'
  end

  get '/tags/' do
    redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  post '/set_filter' do
    correct_search = params[:filter].gsub(' ','%20')
    redirect "/tags/#{correct_search.to_sym}"
  end

  helpers do

    def current_user
       @current_user ||= User.get(session[:user_id])
    end

  end

end
