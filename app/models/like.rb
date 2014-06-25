class Like < ActiveRecord::Base
  validates :user_id, uniqueness: {scope: :photo_id}
  validates :user_id, :photo_id, presence: true
  
  belongs_to :user
  belongs_to :photo
  
  has_many :notifications, as: :notifiable, dependent: :destroy
  
  after_create :create_notification

  private
  
  # maybe don't add if user == current_user
  def create_notification
   Notification.create(
     notifiable: self,
     user: self.user
   )
  end
end
