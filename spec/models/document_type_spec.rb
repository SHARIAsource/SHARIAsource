require 'rails_helper'

# == Schema Information
#
# Table name: document_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  parent_id  :integer
#  sort_order :integer
#

describe DocumentType do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should validate_numericality_of :sort_order }
  it { should have_many :documents }
  it 'is a closure tree' do
    expect(DocumentType).to be_a_closure_tree
  end
end
