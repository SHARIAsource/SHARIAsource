describe Era do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should belong_to :parent }
  it { should have_many :children }
end
