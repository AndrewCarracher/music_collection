require_relative('./model/albums.rb')
require_relative('./model/artists.rb')
require('pry')



artist1 = Artist.new({
  'name' => 'Bob Marley',
  })

artist2 = Artist.new({
  'name' => 'Eminem'
  })

artist1.save()
artist2.save()

album1 = Album.new({
  'artist_id' => artist1.id,
  'title'     => "Buffalo Soldier",
  'genre'     => "reggae"
  })

album2 = Album.new({
  'artist_id' => artist2.id,
  'title'     => "Lose Yourself",
  'genre'     => "rap"
  })

album1.save()
album2.save()

artist = Album.all()
p artist
album = Artist.all()
p album

artist1.albums
album1.artists

binding.pry
nil
