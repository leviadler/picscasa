class Album < ActiveRecord::Base
  enum visibility: [:private_album, :unlisted_album, :public_album]

  validates :title, :date, :owner_id, presence: true
  validates :visibility, presence: true, inclusion: {in: ["private_album", "unlisted_album", "public_album"]}
  #validates_inclusion_of :visibility, in: 0..2

  before_save :ensure_token

  after_create :create_notifications

  belongs_to :owner, class_name: "User", foreign_key: :owner_id

  has_many :photos, dependent: :destroy
  
  def ensure_token
    if self.unlisted_album?
      self.auth_token = SecureRandom.urlsafe_base64(32) if self.auth_token.nil?
    else
      self.auth_token = nil
    end
  end

  def create_notifications
    Notification.create(
      notifiable: self,
      user: self.owner,
      event_type: 'new_album'
    )
  end
end
