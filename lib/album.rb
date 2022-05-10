class Album 
    attr_reader :id
    attr_accessor :name

    @@albums = {}
    @@total_rows=0

    def initialize(name, id)
        @name = name
        @id = id || @@total_rows += 1
    end

    def self.all
        @@albums.values
    end

    def self.clear
        @@albums = {}
        @@total_rows
    end

    def ==(other_album)
        self.name == (other_album.name)
    end

    def save 
        @@albums[self.id] = self
    end

    def self.find(id)
        @@albums[id]
    end

    def update(new_name)
        self.name = new_name
    end

    def delete
        @@albums.delete(self.id)
    end

    def songs 
        Song.find_by_album(self.id)
    end
end