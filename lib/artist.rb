class Artist
  attr_reader :id
  attr_accessor :name

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_artists = DB.exec("SELECT * FROM artists;")
    artists = []
    returned_artists.each do |artist|
      name = artist.fetch("name")
      id = artist.fetch("id")
      artists.push(Artist.new(:name => name, :id => id))
    end
    artists
  end

  def self.clear
    DB.exec("DELETE FROM artists *;")
  end

  def self.find(id)
    artist = DB.exec("SELECT * FROM artists WHERE id = #{id};").first
    name = artist.fetch("name")
    id = artist.fetch("id").to_i
    Artist.new({:name => name, :id => id})
  end

  def ==(other_artist)
    self.name == (other_artist.name)
  end

  def save
    result = DB.exec("INSERT INTO artists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def update(attributes)
    if (attributes.has_key?(:name)) && (attributes.fetch(:name) != nil)
      @name = attributes.fetch(:name)
      DB.exec("UPDATE artists SET name = '#{@name}' WHERE id = #{@id};")
    elsif (attributes.has_key?(:album_name)) && (attributes.fetch(:album_name) != nil)
      album_name = attributes.fetch(:album_name)
      album = DB.exec("SELECT * FROM albums WHERE lower(name)='#{album_name.downcase}';").first
      if (album != nil) && (DB.exec("SELECT FROM albums_artists WHERE album_id = #{@id}") != nil)
          DB.exec("INSERT INTO albums_artists (album_id, artist_id) VALUES (#{album['id'].to_i}, #{@id});")
      end
    end
  end

  def delete
    DB.exec("DELETE FROM albums_artists WHERE artist_id = #{@id};")
    DB.exec("DELETE FROM artists WHERE id = #{@id};")
  end

  # def albums
  #   albums = []
  #   results = DB.exec("SELECT album_id FROM albums_artists WHERE artist_id = #{@id};")
  #     results.each() do |result|
  #       album_id = result.fetch("album_id").to_i()
  #       album = DB.exec("SELECT * FROM albums WHERE id = #{album_id};")
  #       name = album.first().fetch("name")
  #       albums.push(Album.new({:name => name, :id => album_id}))
  #     end
  #   albums
  # end

  def albums
    albums = []
    album_ids = []
    query1_results = DB.exec("SELECT album_id FROM albums_artists WHERE artist_id = #{@id};")
    query1_results.each() do |result|
      album_id = result.fetch("album_id").to_i()
      album_ids.push(album_id)
    end
    album_ids_string = album_ids.join(",")
    if album_ids_string != ""
      query2_results = DB.exec("SELECT * FROM albums WHERE ID in (#{album_ids_string});")
      query2_results.each do |result|
        name = result.fetch("name")
        album_id = result.fetch("id").to_i
        albums.push(Album.new({:name => name, :id => album_id}))
      end
    end
    albums
  end

end