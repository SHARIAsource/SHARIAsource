describe Collaborator do
  it { should validate_presence_of :name }
  it { should respond_to :url }
  it { should respond_to :description }
end
