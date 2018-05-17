class SongsController < ApplicationController
  require 'rack-flash'
  use Rack::Flash
  enable :sessions

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
    @song = Song.find_or_create_by(name: params[:song][:name], artist_id: params[:song][:artist_id])
    if !params["artist"]["name"].empty?
      if Artist.all.find_by(name: params["artist"]["name"])
        @song.artist = Artist.all.find_by(name: params["artist"]["name"])
      else
        @song.artist = Artist.create(params["artist"])
      end
    end
    params[:song][:genre_ids].each do |genre_id|
      @song.genres << Genre.find(genre_id)
    end
    @song.save
    flash[:message] = "Successfully created song."
    redirect "/songs/#{@song.slug}"
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @genres = Genre.all
    @artists = Artist.all

    erb :'songs/edit'
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])

    if !params["artist"]["name"].empty?
      if Artist.all.find_by(name: params["artist"]["name"])
        @song.artist = Artist.all.find_by(name: params["artist"]["name"])
      else
        @song.artist = Artist.create(params["artist"])
      end
    end
    params[:song][:genre_ids].each do |genre_id|
      @song.genres << Genre.find(genre_id)
    end
    @song.save
    flash[:message] = "Successfully updated song."
    redirect "/songs/#{@song.slug}"
    end
  # end

end
