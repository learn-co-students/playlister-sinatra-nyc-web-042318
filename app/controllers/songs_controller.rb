class SongsController < ApplicationController

  get '/songs' do
    @songs = Song.all

    erb :"songs/index"
  end

  get '/songs/new' do
    @artists = Artist.all

    erb :"songs/new"
  end

  post '/songs' do
    @song = Song.create(params[:song])
    
    redirect "/songs/#{@song.slug}"
  end

  get "/songs/:slug/edit" do
    @song = Song.find_by_slug(params["slug"])
    @artists = Artist.all

    erb :"songs/edit"
  end

  get "/songs/:slug" do
    @song = Song.find_by_slug(params["slug"])

    erb :"songs/show"
  end




end
