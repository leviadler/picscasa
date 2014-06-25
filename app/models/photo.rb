class Photo < ActiveRecord::Base
  has_attached_file :image, :styles => {
    :big => "600x600>",
    :thumb => "205x205#"
  }

  validates_attachment :image, presence: true,
    :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] } #maybe limit to jpg


  # not sure if this should be a before or after
  after_image_post_process :load_exif_date

  belongs_to :album
  has_one :owner, through: :album

  has_many :comments
  has_many :likes

  def load_exif_date
    exif = EXIFR::JPEG.new(image.queued_for_write[:original].path)
    return if exif.nil? or not exif.exif?
    if exif.date_time_original
      self.date_taken = exif.date_time_original #.to_time
    else
      self.date_taken = Time.at(0) # or Time.now - not sure which one makes more sense
    end
  end


end
