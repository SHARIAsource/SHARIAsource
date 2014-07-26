describe Body do
  it { should respond_to :text }
  it { should belong_to :static }
end
