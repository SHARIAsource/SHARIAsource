describe Era do
  it { should validate_numericality_of :start_year }
  it { should validate_numericality_of :end_year }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should have_and_belong_to_many :sources }
  it 'is a closure tree' do
    expect(Era).to be_a_closure_tree
  end
end
