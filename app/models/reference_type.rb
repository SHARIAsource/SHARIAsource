# == Schema Information
#
# Table name: reference_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class ReferenceType < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :documents
end
