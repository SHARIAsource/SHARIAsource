describe Source do
  it { should validate_presence_of :title }
  it { should have_and_belong_to_many :themes }
  it { should have_and_belong_to_many :topics }
  it { should have_and_belong_to_many :tags }
  it { should have_and_belong_to_many :eras }
  it { should belong_to :region }
  it { should belong_to :document_type }
end
