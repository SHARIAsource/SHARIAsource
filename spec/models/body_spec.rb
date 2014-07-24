describe Body do
  it { should respond_to :source_text }
  it { should respond_to :rendered_text }
  it { should belong_to :static }
end
