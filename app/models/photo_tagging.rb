class PhotoTagging < ActiveRecord::Base
  belongs_to :photo
  belongs_to :tag

  has_one :owner, through: :photo
end
