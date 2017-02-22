require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'omniauth-github'
require 'sinatra/reloader'
require 'pry'

require_relative 'config/application'
also_reload 'config/application'

set :environment, :development

Dir['app/**/*.rb'].each { |file| require_relative file }

helpers do
  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id) if user_id.present?
  end

  def signed_in?
    current_user.present?
  end
end

def set_current_user(user)
  session[:user_id] = user.id
end

def authenticate!
  unless signed_in?
    flash[:error] = 'You need to sign in if you want to do that!'
    redirect '/'
  end
end

get '/' do
  @title = "Meetups in Space"
  @meetups = Meetup.all.order(name: :asc)
  erb :'meetup/index'
end

get '/meetups/:id' do
  @title = "Meetup Detail"
  @meetup = Meetup.find(params[:id])
  erb :'meetup/show'
end

get '/meetup/new' do
  authenticate!
  @title = "Add a new meetup"
  erb :'meetup/form'
end

get '/users' do
  @title = "Users"
  @users = User.all.order(username: :asc)
  erb :'user/index'
end

get '/users/:id' do
  @title = "User Detail"
  @user = User.find(params[:id])
  erb :'user/show'
end

post '/new_meetup' do
  @meetup = Meetup.create(params[:meetup])
  flash[:notice] = "Your meetup, #{@meetup.name} was successfully created."
  redirect '/meetups/' + @meetup.id.to_s
end

post '/join' do
  authenticate!
  meetup_id = params.invert["Join this meetup"]
  @meetup = Meetup.find(meetup_id)

  if @meetup.users.include?(current_user)
    flash[:error] = "You have already joined this meetup."
  else
    @meetup.users << current_user
    flash[:notice] = "You have successfully joined this meetup."
  end
  redirect '/meetups/' + meetup_id.to_s
end

post '/leave' do
  authenticate!
  meetup_id = params.invert["Leave this meetup"]
  @meetup = Meetup.find(meetup_id)
  if @meetup.users.include?(current_user)
    @meetup.users.delete(current_user)
    flash[:notice] = "You have successfully left this meetup."
  else
    flash[:error] = "You have not yet joined this meetup."
  end
  redirect '/meetups/' + meetup_id.to_s
end

get '/auth/github/callback' do
  auth = env['omniauth.auth']
  user = User.find_or_create_from_omniauth(auth)
  set_current_user(user)
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/example_protected_page' do
  authenticate!
end
