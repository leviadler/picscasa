class User < ActiveRecord::Base
  attr_reader :password

  validates :email, presence: true, uniqueness: true
  validates :lname, :fname, presence: true
  validates :password_digest, presence: { message: "Password can't be blank"}
  validates :password, length: { minimum: 6, allow_nil: true}, confirmation: true

  # keep it simple - http://davidcel.is/blog/2012/09/06/stop-validating-email-addresses-with-regex/ - TODO activation email
  validates_format_of :email, :with => /.+@.+\..+/i

  has_many :sessions
  has_many :albums, foreign_key: :owner_id
  has_many :photos, through: :albums
  has_many :tags, through: :photos

  # doesn't seem necessary as we will never look it up this way
  has_many :comments
  has_many :likes
  has_many :notifications

  MAX_SIZE = 5.megabytes

  has_attached_file :avatar, styles: { :medium => "300x300#", :thumb => "100x100#" },
                             default_url: "/images/avatar/:style/default_avatar.png"

  validates_attachment :avatar,
    :content_type => { :content_type => ["image/jpeg", "image/png"], message: "must be a jpg or png" },
    size: {less_than: MAX_SIZE, message: "must be under #{ MAX_SIZE / 1.megabyte }Mb"}

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def name
    "#{self.fname} #{self.lname}"
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    user.try(:is_password?, password) ? user : nil
  end

end
