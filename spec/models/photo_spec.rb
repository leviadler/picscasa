RSpec.describe Photo, :type => :model do
  it { should belong_to(:album) }
  it { should have_one(:owner) }
  it { should have_many(:comments)}
  it { should have_many(:likes)}
end
