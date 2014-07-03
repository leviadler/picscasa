class Tag < ActiveRecord::Base
  has_many :photo_taggings
  has_many :photos, through: :photo_taggings
  
  def self.with_user_photo_count(user)
    self.joins(:photo_taggings => { :photo => :album  } )
        .select("tags.*, COUNT(photos.id) AS photo_count")
        .where("albums.owner_id = ?", user.id)
        .group("tags.id")
  end
  
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
end