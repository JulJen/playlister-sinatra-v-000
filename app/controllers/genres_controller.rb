class GenresController < ApplicationController

  get '/genres' do
    @genres = Genre.all
    erb :'genres/index'
  end

  get '/artists/:slug' do
    @genre = Genre.find_by_slug(params[:slug])
    erb :'genre/show'
  end

end
