require 'sinatra'
require 'sinatra/reloader'
require './lib/album'
require 'pry'
require './lib/song'
also_reload 'lib/**/*.rb'


get '/' do
  @albums = Album.all
  erb(:albums)
end
  
get '/albums' do
  @albums = Album.all
  erb(:albums)
end

get '/albums/new' do
  erb(:new_album_form)
end

get '/albums/:id' do
  @album = Album.find(params[:id].to_i)
  erb(:album_detail)
end

get '/albums/:id/edit' do
  @album = Album.find(params[:id].to_i)
  erb(:edit_album)
end

patch '/albums/:id' do
  album = Album.find(params[:id].to_i)
  album.update(params[:name])
  @albums = Album.all
  erb(:albums)
end

post '/albums' do
  # binding.pry
  name = params[:album_name]
  new_album = Album.new(name, nil)
  new_album.save
  @albums = Album.all
  erb(:albums)
end

get '/albums/:id/songs/:song_id' do
  @song = Song.find(params[:song_id].to_i)
  erb(:song)
end

post '/albums/:id/songs' do
  @album = Album.find(params[:id].to_i)
  song = Song.new(params[:song_name],@album.id, nil)
  song.save
  erb(:album_detail)
end

patch '/albums/:id/songs/:song_id' do
  @album = Album.find(params[:id].to_i)
  song = Song.find(params[:song_id].to_i)
  song.update(params[:name], @album.id)
  erb(:album_detail)
end

delete '/albums/:id/songs/:song_id' do
  song = Song.find(params[:song_id].to_i)
  song.delete
  @album = Album.find(params[:id].to_i)
  erb(:album_detail)
end