require "sinatra"
require "sinatra/activerecord"
require "pry"

set :views, File.join(File.dirname(__FILE__), "app/views")
require_relative "app/models/television_show"

get "/" do
  redirect "/television_shows"
end

get "/television_shows" do
  shows = TelevisionShow.all
  erb :index, locals: { shows: shows }
end

get "/television_shows/new" do
  show = TelevisionShow.new
  errors = ''
  erb :new, locals: { show: show, errors: errors }
end

get "/television_shows/:id" do
  show = TelevisionShow.find(params[:id])
  erb :show, locals: { show: show }
end

get "/television_shows/:id/edit" do
  show = TelevisionShow.find(params[:id])
  errors = ''
  erb :edit, locals: { show: show, errors: errors }
end

post "/television_shows/edit" do
  show = TelevisionShow.new(params[:television_show])

  if show.save
    redirect "/television_shows/#{show.id}"
  else
    errors = show.errors.full_messages
    erb :edit, locals: { show: show, errors: errors }
  end
end

post "/television_shows/new" do
  show = TelevisionShow.new(params[:television_show])

  if show.save
    redirect "/television_shows"
  else
    errors = show.errors.full_messages
    erb :new, locals: { show: show, errors: errors }
  end
end
