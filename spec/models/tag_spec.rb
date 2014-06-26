describe Tag do
  it { should have_many(:photo_taggings) }
  it { should have_many(:photos) }
end
