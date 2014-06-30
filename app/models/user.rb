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

  after_create :create_notifications


  # avatar
  MAX_SIZE = 5.megabytes

  has_attached_file :avatar, styles: { :medium => "300x300#", :thumb => "100x100#" },
                    default_url: ActionController::Base.helpers.asset_path('avatar/missing_:style.png')

  validates_attachment :avatar,
    :content_type => { :content_type => ["image/jpeg", "image/png"], message: "must be a jpg or png" },
    size: {less_than: MAX_SIZE, message: "must be under #{ MAX_SIZE / 1.megabyte }Mb"}


  # Activation
  #before_create :ensure_activation_token

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    hash = BCrypt::Password.new(self.password_digest)
    return false unless hash
    hash.is_password?(password)
  end

  def name
    "#{self.fname} #{self.lname}"
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    user.try(:is_password?, password) ? user : nil
  end

  def self.find_or_create_by_auth_hash(auth_hash)
      user = User.find_by(provider: auth_hash[:provider], uid: auth_hash[:uid])

      return user if user

      user = User.new(provider: auth_hash[:provider],
                      uid: auth_hash[:uid],
                      email: auth_hash[:info][:email],
                      fname: auth_hash[:info][:first_name],
                      lname: auth_hash[:info][:last_name],
                      avatar: auth_hash[:info][:image],
                      password_digest: Bcrypt::Password.create(SecureRandom.urlsafe_base64(64))
                      )
      user.save
      return user
    end

  # def ensure_activation_token
#     activation_token = SecureRandom.urlsafe_base64(32)
#
#     self.activation_token ||= activation_token
#   end
#
#   # not implemented
#   # def reset_activation_token!
# #     self.activation_token = SecureRandom.urlsafe_base64(32)
# #     self.is_activated = false
# #     self.save
# #   end
#
#   def activate!
#     self.update_attribute(:is_activated, true)
#   end

  def already_liked?(photo)
    Like.find_by(user_id: self.id, photo_id: photo.id)
  end


  def create_notifications
    Notification.create(
      notifiable: self,
      user: self,
      event_type: 'new_account'
    )
  end

end
