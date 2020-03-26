require("pry")
require_relative("../models/album")
require_relative("../models/artist")

Album.delete_all() #Albums needs to be deleted first since it is the "many" in the DB structure
Artist.delete_all()

artist1 = Artist.new({
  "name" => "Iron Maiden"
  })

artist1.save()

album1 = Album.new({
  'artist_id' => artist1.id,
  'title' => "Power Slave",
  'genre' => "Metal"
  })

album1.save()

customer1.save()

#binding.pry

nil
