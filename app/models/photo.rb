class Photo < ActiveRecord::Base
  has_attached_file :image, :styles => {
    :big => "600x600>",
    :thumb => "50x50#"
  }
  
  validates_attachment :image, presence: true,
    :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
    
  
  belongs_to :album
  
  
end
