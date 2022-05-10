require 'rspec'
require 'album'

describe 'Album' do
    before :each do
      Album.clear
    end

    describe '.all' do
        it 'returns an empty array when there are no albums' do
            expect(Album.all).to(eq([]))
        end

        it 'returns an array containing all saved albums' do
            album1 = Album.new("blue", nil)
            album1.save
            album2 = Album.new('love supreme', nil)
            album2.save
            expect(Album.all).to(eq([album1, album2]))
        end
    end

    describe '.clear' do
        it 'deletes all albums from @@albums mock database' do
            album1 = Album.new("blue", nil)
            album1.save
            album2 = Album.new('love supreme', nil)
            album2.save
            Album.clear
            expect(Album.all).to(eq([])) 
        end
    end

    describe '#==' do
        it 'is the same album if it has the same name' do
            album1 = Album.new("blue", nil)
            album1.save
            album2 = Album.new('blue', nil)
            album2.save
            expect(album1).to(eq(album2))
        end
    end

    describe '#save' do
        it 'saves an album object in the @@albums hash' do
            album1 = Album.new("blue", nil)
            album1.save
            album2 = Album.new('love supreme', nil)
            album2.save
            expect(Album.all).to(eq([album1, album2]))
        end
    end

    describe '.find' do
        it 'returns an album by id' do
            album1 = Album.new("blue", nil)
            album1.save
            album2 = Album.new('love supreme', nil)
            album2.save  
            expect(Album.find(album1.id)).to(eq(album1))
        end
    end 

    describe '#update' do
        it 'updates an albums name' do
            album1 = Album.new("blue", nil)
            album1.save
            album1.update("Blue")
            expect(album1.name).to(eq("Blue"))
        end
    end

    describe '#delete' do
        it 'deletes an album from the @@albums mock database' do
            album1 = Album.new("blue", nil)
            album1.save
            album1.delete
            expect(Album.all).to(eq([]))
        end
    end

    describe '#songs' do
        it "returns all songs on an album" do
            album = Album.new("Giant Steps", nil)
            album.save
            song = Song.new("Naima", album.id, nil)
            song.save
            song2 = Song.new("Cousin Mary", album.id, nil)
            song2.save
            expect(album.songs).to(eq([song, song2]))
        end
    end
end