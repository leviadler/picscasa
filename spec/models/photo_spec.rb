RSpec.describe Photo, :type => :model do
  it { should belong_to(:album) }
  it { should have_one(:owner) }
  it { should have_many(:comments)}
  it { should have_many(:likes)}
  it { should have_many(:photo_taggings)}
  it { should have_many(:tags)}
  
  
  it { should have_attached_file(:image) }
  it { should validate_attachment_presence(:image) }
  it { should validate_attachment_content_type(:image).
               allowing('image/png', 'image/jpeg', "image/gif").
               rejecting('text/plain', 'text/xml') }
  it { should validate_attachment_size(:image).
               less_than(6.megabytes) }
end
