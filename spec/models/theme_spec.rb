# == Schema Information
#
# Table name: themes
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  archived   :boolean          default(FALSE)
#

describe Theme do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should respond_to :archived }
  it { should have_and_belong_to_many(:documents) }
end
