describe Static do
  it { should validate_presence_of :slug }
  it { should validate_uniqueness_of :slug }
  it { should validate_presence_of :title }
  it { should have_one(:body).dependent(:destroy) }
  it { should accept_nested_attributes_for(:body) }
end
