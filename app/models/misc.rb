class Misc < ActiveRecord::Base
  alias_attribute :name, :title

  validates :slug, presence: true, uniqueness: true
  validates :title, presence: true
end
