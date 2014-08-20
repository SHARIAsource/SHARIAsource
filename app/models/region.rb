# == Schema Information
#
# Table name: regions
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  parent_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Region < ActiveRecord::Base
  acts_as_tree order: 'name'
  validates :name, presence: true, uniqueness: true
  has_and_belongs_to_many :documents
end
