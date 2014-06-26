describe User do

  it { should ensure_length_of(:password).is_at_least(6) }
  it { should validate_confirmation_of(:password) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest).with_message("Password can't be blank") }
  it { should validate_presence_of(:fname) }
  it { should validate_presence_of(:lname) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:sessions) }
  it { should have_many(:albums) }
  it { should have_many(:photos) }
  it { should have_many(:comments) }
  it { should have_many(:likes) }
  it { should have_many(:notifications) }
  
  it { should have_attached_file(:avatar) }
  it { should validate_attachment_content_type(:avatar).
               allowing('image/png', 'image/jpeg').
               rejecting('text/plain', 'text/xml') }
  it { should validate_attachment_size(:avatar).
               less_than(5.megabytes) }

  it "should find user by credentials" do
    user = create(:user)
    expect(User.find_by_credentials(user.email, user.password)).to eq user
  end

end