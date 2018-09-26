require('pg')

class SqlRunner

  def self.run(sql, values = [])
    db = PG.connect({ # connects to db
      dbname: 'music_lib', #db name
      host: 'localhost' #db location
    })
    db.prepare('query', sql)

    results = db.exec_prepared('query', values)

    db.close()
    return results
  end

end
