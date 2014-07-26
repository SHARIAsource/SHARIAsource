describe Region do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should have_many :sources }
  it 'is a closure tree' do
    expect(Region).to be_a_closure_tree
  end
end
