# == Schema Information
#
# Table name: collaborators
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  url         :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

describe Collaborator do
  it { should validate_presence_of :name }
  it { should respond_to :url }
  it { should respond_to :description }
  it { should have_many :users }
end
