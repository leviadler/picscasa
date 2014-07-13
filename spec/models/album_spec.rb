RSpec.describe Album, :type => :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:owner_id) }
  it { should validate_presence_of(:visibility) }
  it { should belong_to(:owner) }
  it { should have_many(:photos) }
  it { should have_many(:notifications) }
  #it { should ensure_inclusion_of(:visibility).in_array(["private_album", "unlisted_album", "public_album"]) }
end
