describe Session do
  it { should validate_presence_of(:user_id) }
  it { should validate_uniqueness_of(:session_token) }
  it { should belong_to(:user) }
end