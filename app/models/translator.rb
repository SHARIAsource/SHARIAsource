class Translator < ActiveRecord::Base
  has_and_belongs_to_many :document

  validates :name, presence: true
end
