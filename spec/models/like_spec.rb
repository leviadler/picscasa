RSpec.describe Like, :type => :model do
  it { should belong_to(:user) }
  it { should belong_to(:photo) }
  it { should have_many(:notifications) }
end
