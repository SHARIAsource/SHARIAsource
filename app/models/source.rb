class Source < ActiveRecord::Base
  alias_attribute :name, :title

  validates :title, presence: true

  has_and_belongs_to_many :themes
  has_and_belongs_to_many :topics
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :eras
  belongs_to :region
  belongs_to :document_type
end
