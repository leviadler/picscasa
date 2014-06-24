class User < ActiveRecord::Base
  attr_reader :password
  
  validates :email, presence: true, uniquness: true
  validates :lname, :fname, presence: true
  validates :password_digest, presence: { message: "Password can't be blank"}
  validates :password, length: { minimum: 6, allow_nil: true}, confirmation: true
  
  has_many :sessions
  
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
    user = User.find(email: email)
    user.try(:is_password?, password) ? user : nil
  end
  
end
