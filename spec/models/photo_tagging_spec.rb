describe PhotoTagging do
  it { should belong_to(:photo) }
  it { should belong_to(:tag) }
  it { should have_one(:owner) }
end
