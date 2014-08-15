# == Schema Information
#
# Table name: commentaries
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  contributor_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Commentary < ActiveRecord::Base
  alias_attribute :name, :title
  validates :title, presence: true
  validates :contributor_id, presence: true
  belongs_to :contributor, class_name: 'User'
  has_one :body
  has_and_belongs_to_many :sources
  accepts_nested_attributes_for :body
  default_scope { order('created_at DESC') }
end
