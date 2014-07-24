class Static < ActiveRecord::Base
  alias_attribute :name, :title

  validates :slug, presence: true, uniqueness: true
  validates :title, presence: true

  has_one :body, dependent: :destroy
  accepts_nested_attributes_for :body
end
