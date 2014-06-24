describe User do

  it { should ensure_length_of(:password).is_at_least(6) }
  it { should validate_confirmation_of(:password) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:fname) }
  it { should validate_presence_of(:lname) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:sessions) }
  
  it "should find user by credentials" do
    user = create(:user)
    expect(User.find_by_credentials(user.email, user.password)).to eq user
  end
  
end