class Tag < ActiveRecord::Base
  has_many :photo_taggings
  has_many :photos, through: :photo_taggings
  
  
  extend FriendlyId
  friendly_id :name, :use => :slugged
end