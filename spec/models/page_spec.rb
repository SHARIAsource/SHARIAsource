describe Page do
  it { should respond_to :image }
  it { should have_many(:bodies).dependent(:destroy) }
  it { should belong_to :source }
end
