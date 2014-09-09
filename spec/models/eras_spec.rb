describe Era do
  it { should validate_numericality_of :start_year_gregorian }
  it { should validate_numericality_of :end_year_gregorian }
  it { should validate_numericality_of :start_year_hijri }
  it { should validate_numericality_of :end_year_hijri }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should respond_to :extended }
  it { should respond_to :hijri_display }
  it { should respond_to :gregorian_display }
  it { should have_and_belong_to_many :documents }
  it 'is a closure tree' do
    expect(Era).to be_a_closure_tree
  end
end
