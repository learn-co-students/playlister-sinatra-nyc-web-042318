class SongsController < ApplicationController

  get '/songs' do
    @songs = Song.all
    erb :'songs/index'
  end

  get '/songs/new' do
    @artists = Artist.all
    @genres = Genre.all
    erb :'songs/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])

    erb :'songs/show'
  end

  post '/songs' do
    @song = Song.find_or_create_by(params[:song])
    if !params["artist"]["name"].empty?
      if Artist.all.find_by(name: params["artist"]["name"])
        @song.artist = Artist.all.find_by(name: params["artist"]["name"])
      else
        @song.artist = Artist.create(params["artist"])
      end
    end
    @song.save
    redirect "/songs/#{@song.slug}"
  end

end
