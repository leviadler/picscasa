class Photo < ActiveRecord::Base
  has_attached_file :image, :styles => {
    :big => "600x600>",
    :thumb => "205x205#"
  }


  MAX_SIZE = 6.megabytes

  validates_attachment :image, presence: true,
    content_type: { content_type: ["image/jpeg", "image/gif", "image/png"], message: "must be a jpg, png or gif" },
    size: {less_than: MAX_SIZE, message: "must be under #{ MAX_SIZE / 1.megabyte }Mb"} #maybe limit to jpg


  # not sure if this should be a before or after
  after_image_post_process :load_exif_date

  belongs_to :album
  has_one :owner, through: :album

  has_many :comments
  has_many :likes

  has_many :photo_taggings
  has_many :tags, through: :photo_taggings


  def tag_list
    self.tags.map do |tag|
      tag.name
    end.join(", ")
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").collect {|t| t.strip.downcase}.uniq
    new_or_found_tags = tag_names.map {|name| Tag.find_or_create_by(name: name)}
    self.tags = new_or_found_tags
  end

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
