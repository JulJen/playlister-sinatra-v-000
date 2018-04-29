require 'rack-flash'

class SongsController < ApplicationController
  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :'songs/index'
  end

  get '/songs/new' do
    erb :'songs/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end

  post '/songs' do
    @song = Song.create(:name => params["song_name"])
    @song.artist = Artist.find_or_create_by(:name => params["artist_name"])
    @song.genre_ids = params[:genres]
    @song.save

    flash[:message] = "Success! New song added!"
    redirect "/songs/#{@song.slug}"
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @genres = Genre.all
    erb :'/songs/edit'
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @song.update(params[:song])
    @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
    @song.save

    flash[:message] = "Success! Song updated!"
    redirect "/songs/#{@song.slug}"
  end


  post '/set-flash' do
    # Set a flash entry
    flash[:notice] = "Success! New song added!"

    # Get a flash entry
    flash[:notice] # => "Success!"

    # Set a flash entry for only the current request
    flash.now[:notice] = "New song successfully added!"
  end


end
