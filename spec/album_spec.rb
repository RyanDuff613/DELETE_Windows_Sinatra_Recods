require 'spec_helper'

describe 'Album' do

    describe '.all' do
        it 'returns an empty array when there are no albums' do
            expect(Album.all).to(eq([]))
        end

        it 'returns an array containing all saved albums' do
            album1 = Album.new({:name => "blue",:id => nil})
            album1.save
            album2 = Album.new({:name => 'love supreme', :id => nil})
            album2.save
            expect(Album.all).to(eq([album1, album2]))
        end
    end

    describe '.clear' do
        it 'deletes all albums from @@albums mock database' do
            album1 = Album.new({:name => "blue",:id => nil})
            album1.save
            album2 = Album.new({:name => 'love supreme', :id => nil})
            album2.save
            Album.clear
            expect(Album.all).to(eq([])) 
        end
    end

    describe '#==' do
        it 'is the same album if it has the same name' do
            album1 = Album.new({:name => "blue",:id => nil})
            album1.save
            album2 = Album.new({:name => 'blue', :id => nil})
            album2.save
            expect(album1).to(eq(album2))
        end
    end

    describe '#save' do
        it 'saves an album object in the @@albums hash' do
            album1 = Album.new({:name => "blue",:id => nil})
            album1.save
            album2 = Album.new({:name => 'love supreme', :id => nil})
            album2.save
            expect(Album.all).to(eq([album1, album2]))
        end
    end

    describe '.find' do
        it 'returns an album by id' do
            album1 = Album.new({:name => "blue",:id => nil})
            album1.save
            album2 = Album.new({:name => 'love supreme', :id => nil})
            album2.save 
            expect(Album.find(album1.id)).to(eq(album1))
        end
    end 

    describe '#update' do
        it 'updates an albums name' do
            album1 = Album.new({:name => "blue",:id => nil})
            album1.save
            album1.update("Blue")
            expect(album1.name).to(eq("Blue"))
        end
    end

    describe '#delete' do
        it 'deletes an album from the @@albums mock database' do
            album1 = Album.new({:name => "blue",:id => nil})
            album1.save
            album1.delete
            expect(Album.all).to(eq([]))
        end
    end

    describe '#songs' do
        it "returns all songs on an album" do
            album1 = Album.new({:name => "blue",:id => nil})
            album1.save
            song = Song.new({:name => "Naima",:album_id => album1.id, :id => nil})
            song.save
            song2 = Song.new({:name => "Cousin Mary", :album_id => album1.id, :id => nil})
            song2.save
            expect(album1.songs).to(eq([song, song2]))
        end
    end

    describe '#artist' do
        it 'returns an albums artist' do
            album = Album.new({:name => "Definitely Maybe",:id => nil})
            album.save
            artist = Artist.new({:name => 'Oasis', :id => nil}) 
            artist.save
            artist.update({:album_name => "Definitely Maybe"})
            expect(album.artist).to(eq(artist))
        end
    end
end