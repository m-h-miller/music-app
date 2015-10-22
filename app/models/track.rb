class Track < ActiveRecord::Base
  belongs_to(
    :album,
    class_name: "Album",
    primary_key: :id,
    foreign_key: :album_id
  )

  has_one(
    :band,
    through: :album,
    source: :band
  )
end
