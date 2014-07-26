# == Schema Information
#
# Table name: statics
#
#  id         :integer          not null, primary key
#  slug       :string(255)
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

describe Static do
  it { should validate_presence_of :slug }
  it { should validate_uniqueness_of :slug }
  it { should validate_presence_of :title }
  it { should have_one(:body).dependent(:destroy) }
  it { should accept_nested_attributes_for(:body) }
end
