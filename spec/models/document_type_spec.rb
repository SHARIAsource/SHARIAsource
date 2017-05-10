require 'rails_helper'

describe DocumentType do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should validate_numericality_of :sort_order }
  it { should have_many :documents }
  it 'is a closure tree' do
    expect(DocumentType).to be_a_closure_tree
  end
end
