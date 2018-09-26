require('pg')
require_relative('../db/sql_runner.rb')

class Artist

  attr_accessor(:name)
  attr_reader(:id)

  def initialize(options)
    @id           = options['id'].to_i()
    @name         = options['name']
  end

  def self.delete_all()
      sql = 'DELETE FROM artists;'
      SqlRunner.run(sql)
    end

    def self.all()
      sql = 'SELECT * FROM artists;'

      order_hashes = SqlRunner.run(sql)

      order_objects = order_hashes.map do |order_hash|
        Artist.new(order_hash)
      end

      return order_objects
    end

    def save()
      sql = "
        INSERT INTO  artists (
          name
        )
        VALUES ($1)
        RETURNING id;
      "
      values = [
        @name
      ]

      result = SqlRunner.run(sql, values)

      @id = result[0]['id'].to_i()
    end

    def update()
      sql = "
        UPDATE artists
        SET (
          name
        ) = ( $1)
        WHERE id = $2;
      "
      values = [
        @name,
        @id
      ]

      SqlRunner.run(sql, values)
    end

    def find()
        sql = "SELECT * FROM artists WHERE id = $1;"

        order_hashes = SqlRunner.run(sql, [@artist_id])

        order_objects = order_hashes.map do |order_hash|
          Artist.new(order_hash)
        end

        return order_objects
    end

    def self.delete()
      # customer = find(id)
      sql = "DELETE FROM artists WHERE id = $1;"
      SqlRunner.run(sql, [$artist_id])
    end

    def albums()
      #returns an array of customer orders using @id
      sql = "SELECT * FROM albums WHERE artist_id = $1;"
      results = SqlRunner.run(sql, [@id])

      artist_album = results.map do |order_hash|
        Album.new(order_hash)
      end
      return artist_album
    end
  end
