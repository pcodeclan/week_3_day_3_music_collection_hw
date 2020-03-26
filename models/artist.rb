require_relative("../db/sql_runner.rb")

class Artist
  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO artists (name) VALUES $1 RETURNING *"
    values = [@name]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql, [])
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    artist_hash = SqlRunner.run(sql ,values).first()
    return nil if artist_hash == nil
    return Artist.new(artist_hash)
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    album_hash = SqlRunner.run(sql, values)
    return album_hash.map{|new_album_hash| Album.new(new_album_hash)}
  end

end
