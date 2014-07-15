describe Era do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it 'is a closure tree' do
    expect(Era).to be_a_closure_tree
  end
end
