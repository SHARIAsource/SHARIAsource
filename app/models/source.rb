class Source < ActiveRecord::Base
  alias_attribute :name, :title

  validates :title, presence: true

  has_and_belongs_to_many :themes
end
