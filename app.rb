require 'sinatra'
require 'sinatra/reloader'
require './lib/album'
require 'pry'
require './lib/song'
require 'pg'
require './db_access.rb'
also_reload 'lib/**/*.rb'


get '/' do
  @albums = Album.all
  @artists = Artist.all
  erb(:index)
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
  new_album = Album.new({:name => name, :id => nil})
  new_album.save
  @albums = Album.all
  erb(:albums)
end

delete '/albums/:id' do
  album = Album.find(params[:id])
  album.delete
  @albums = Album.all
  erb(:albums)
end

get '/albums/:id/songs/:song_id' do
  @song = Song.find(params[:song_id].to_i)
  erb(:song)
end

post '/albums/:id/songs' do
  @album = Album.find(params[:id].to_i)
  song = Song.new({:name => params[:song_name], :album_id => @album.id, :id => nil})
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

get '/artists' do
  @artists = Artist.all
  erb(:artists)
end

get '/artists/new' do
  erb(:new_artist)
end

get '/artists/:id' do
  @artist = Artist.find(params[:id])
  erb(:artist)
end

get '/artists/:id/edit' do
  @artist = Artist.find(params[:id])
  erb(:edit_artist)
end

post '/artists' do
  new_artist = Artist.new({:name => params[:artist_name], :id => nil})
  new_artist.save
  @artists = Artist.all
  erb(:artists)
end

patch '/artists/:id' do
  @artist = Artist.find(params[:id])
  @artist.update({:name => params[:artist_name]})
  erb(:artist)
end

delete '/artists/:id' do
  artist = Artist.find(params[:id])
  artist.delete
  @artists = Artist.all
  erb(:artists)
end