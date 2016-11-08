require 'rails_helper'

# == Schema Information
#
# Table name: reference_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

describe ReferenceType do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should have_many :documents }
end
