require_relative('../db/sql_runner.rb')
require_relative('./artist')

class Album

  attr_accessor
  attr_reader :id

  def initialize(options)
    @title = options['title']
    @genre = options['genre']
    @id = options['id'].to_i if options['id']
    @artist_id = options['id'].to_i
  end

  def save()
    sql = "INSERT INTO albums (artist_id, title, genre) VALUES ($1,$2,$3) RETURNING id"
    values = [@artist_id, @title, @genre]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update()
    sql = "UPDATE albums SET (artist_id, title, genre) = ($1, $2, $3) WHERE id = $4"
    values = [@customer_id, @topping, @quantity]
    @id = SqlRunner.run(sql,values)[0]['id'].to_i
  end

  def delete()
    sql = "DELETE FROM albums where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    album_hash = results.first()
    album = Album.new(album_hash)
    return album
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql,[])
  end

  def self.all()
    sql = "SELECT * FROM albums"
    results = SqlRunner.run(sql, [])
    return results.map {|result_hash| Album.new(result)}
  end

  def artist()
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [@artist_id]
    artist_hash = SqlRunner.run(sql, values)[0]
    return Artist.new(artist_hash)
  end


end
