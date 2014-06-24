class Album < ActiveRecord::Base
  enum visibility: [:private_album, :unlisted_album, :public_album]
  
  validates :title, :date, :owner_id, presence: true
  validates :visibility, presence: true, inclusion: {in: ["private_album", "unlisted_album", "public_album"]}
  #validates_inclusion_of :visibility, in: 0..2
  
  belongs_to :owner, class_name: "User", foreign_key: :owner_id
  
  #has_many photos
end
