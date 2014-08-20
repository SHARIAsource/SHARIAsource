# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

describe Topic do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should have_and_belong_to_many :documents }
end
