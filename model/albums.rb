require('pg')
require_relative('../db/sql_runner.rb')


class Album

  attr_accessor(:title, :genre)

  attr_reader(:id, :artist_id)

  def initialize(options)
    @id          = options['id'].to_i()
    @artist_id   = options["artist_id"].to_i()
    @title       = options['title']
    @genre       = options['genre']
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1;"

    results = SqlRunner.run(sql, [@artist_id])
    artist_hash = results[0]
    artist = Artist.new(artist_hash)
    return artist
  end

  def self.delete_all()
    sql = 'DELETE FROM albums;'
    SqlRunner.run(sql)
  end

  def self.all()
      sql = 'SELECT * FROM albums;'

      order_hashes = SqlRunner.run(sql)

      order_objects = order_hashes.map do |order_hash|
        Album.new(order_hash)
      end

      return order_objects
  end

  def save()
    sql = "
      INSERT INTO  albums (
        artist_id,
        title,
        genre
      )
      VALUES ($1, $2, $3)
      RETURNING id = $4;
    "
    values = [
      @artist_id,
      @title,
      @genre,
      @id]

    result = SqlRunner.run(sql, values)

    @id = result[0]['id'].to_i()
  end

  def update()
      sql = "
        UPDATE albums
        SET (
          artist_id,
          title,
          genre
        ) = ( $1, $2, $3 )
        WHERE id = $4;
      "
      values = [
        @artist_id,
        @title,
        @genre,
        @id
      ]

      SqlRunner.run(sql, values)
  end

  def artists()
    #returns an array of customer orders using @id
    sql = "SELECT * FROM artists WHERE id = $1;"
    results = SqlRunner.run(sql, [@id])

    artist = results.map do |order_hash|
      Album.new(order_hash)
    end
    return artist
  end

end
