class Album 
    attr_reader :id
    attr_accessor :name

    def initialize(attributes)
        @name = attributes.fetch(:name)
        @id = attributes.fetch(:id)
    end

    def self.all
        returned_albums = DB.exec("SELECT * FROM albums;")
        albums = []
        returned_albums.each do |album|
            name = album.fetch("name")
            id = album.fetch("id").to_i
            albums.push(Album.new({:name => name, :id => id}))
        end
        albums
    end

    def self.clear
        DB.exec("DELETE FROM albums *;")
    end

    def ==(other_album)
        self.name == (other_album.name)
    end

    def save 
        result = DB.exec("INSERT INTO albums (name) VALUES ('#{@name}') RETURNING id;")
        @id = result.first.fetch("id").to_i
    end

    def self.find(id)
        album = DB.exec("SELECT * FROM albums WHERE id = #{id};").first
        name = album.fetch("name")
        id = album.fetch("id").to_i
        Album.new({:name => name, :id => id})
    end

    def update(new_name)
        @name = new_name
        DB.exec("UPDATE albums SET name = '#{@name}' WHERE id = #{@id};")
    end

    def delete
        DB.exec("DELETE FROM albums WHERE id = #{@id};")
        DB.exec("DELETE FROM songs WHERE album_id = #{@id};")
        DB.exec("DELETE FROM albums_artists WHERE album_id = #{@id}")
    end

    def songs 
        Song.find_by_album(self.id)
    end

    def artist
        result = DB.exec("SELECT * FROM albums_artists WHERE album_id = #{@id};")
        artist_id = result.first.fetch("artist_id").to_i
        # binding.pry
        Artist.find(artist_id)
    end
end