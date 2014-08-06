class Commentary < ActiveRecord::Base
  alias_attribute :name, :title
  validates :title, presence: true
  validates :contributor_id, presence: true
  belongs_to :contributor, class_name: 'User'
  has_one :body
  accepts_nested_attributes_for :body
end
