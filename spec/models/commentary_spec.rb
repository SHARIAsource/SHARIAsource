describe Commentary do
  it { should validate_presence_of :title }
  it { should validate_presence_of :contributor_id }
  it { should belong_to :contributor }
  it { should have_one :body }
  it { should accept_nested_attributes_for :body }
end
