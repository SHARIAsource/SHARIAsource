# == Schema Information
#
# Table name: document_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  parent_id  :integer
#

describe DocumentType do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should have_many :sources }
  it 'is a closure tree' do
    expect(DocumentType).to be_a_closure_tree
  end
end
