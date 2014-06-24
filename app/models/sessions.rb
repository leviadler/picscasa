class Session < ActiveRecord::Base
  validates :user_id, presence: true
  validates :session_token, presence: true, uniqueness: true
  
  before_validation :ensure_session_token
  
  belongs_to :user
  
  
  private
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16);
  end
  
end
