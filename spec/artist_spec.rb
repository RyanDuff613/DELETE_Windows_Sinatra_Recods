require 'spec_helper'

describe '#Artist' do

  describe 'initialize' do
    it 'creates an instance of an artist' do
      artist = Artist.new({:name => "Oasis", :id => nil})
      expect(artist.name).to(eq("Oasis"))
    end
  end

  describe '.all' do
    it 'returns an array of all artists' do
      artist1 = Artist.new({:name => "Oasis", :id => nil})
      artist1.save
      artist2 = Artist.new({:name => "The Beatles", :id => nil})
      artist2.save
      expect(Artist.all).to(eq([artist1, artist2]))
    end
  end

  describe '.clear' do
    it 'clears all artists from the database' do 
      artist1 = Artist.new({:name => "Oasis", :id => nil})
      artist1.save
      artist2 = Artist.new({:name => "The Beatles", :id => nil})
      artist2.save
      Artist.clear
      expect(Artist.all).to(eq([]))
    end
  end

  describe '.find' do
    it "finds an artist by their id" do
      artist = Artist.new({:name => "Oasis", :id => nil})
      artist.save
      expect(Artist.find(artist.id)).to(eq(artist))
    end
  end

  describe '==' do
    it 'returns true if two artists have the same name' do
      artist1 = Artist.new({:name => "Oasis", :id => nil})
      artist1.save
      artist2 = Artist.new({:name => "Oasis", :id => nil})
      artist2.save
      expect(artist1==artist2).to(eq(true))
    end
  end

  describe '#save' do
    it 'saves an artist in the database' do
      artist = Artist.new({:name => "Oasis", :id => nil})
      artist.save
      expect(Artist.find(artist.id)).to(eq(artist))
    end
  end

  describe '#update' do
    it("adds an album to an artist") do
      artist = Artist.new({:name => "Oasis", :id => nil})
      artist.save
      album = Album.new({:name => "Whats the story morning glory?", :id => nil})
      album.save
      artist.update({:album_name => "Whats the story morning glory?"})
      expect(artist.albums).to(eq([album]))
    end

    it('updates an artists name') do
      artist = Artist.new({:name => "Oasi", :id => nil})
      artist.save
      artist.update({:name => "Oasis"})
      expect(artist.name).to(eq("Oasis"))
    end

    it 'will not make an association between an artist and an album more than once' do
      artist = Artist.new({:name => "Oasis", :id => nil})
      artist.save
      album = Album.new({:name => "Whats the story morning glory?", :id => nil})
      album.save
      artist.update({:album_name => "Whats the story morning glory?"})
      artist.update({:album_name => "Whats the story morning glory?"})
      expect(artist.albums).to(eq([album]))
    end
  end

  describe '#delete' do
    it('deletes an artist from the database') do
      artist = Artist.new({:name => "Oasis", :id => nil})
      artist.save
      artist.delete
      expect(Artist.all).to(eq([]))
    end
  end

  describe '#albums' do
    it('returns all albums associated with an artist') do
      artist = Artist.new({:name => "Oasis", :id => nil})
      artist.save
      album1 = Album.new({:name => "Whats the story morning glory?", :id => nil})
      album1.save
      album2 = Album.new({:name => "Definitely Maybe", :id => nil})
      album2.save
      artist.update({:album_name => "Whats the story morning glory?"})
      artist.update({:album_name => "Definitely Maybe"})
      expect(artist.albums).to(eq([album1, album2]))
    end
  end
end