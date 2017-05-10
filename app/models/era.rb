class Era < ActiveRecord::Base
  acts_as_tree order: { start_year_gregorian: :asc }
  validates :name, presence: true, uniqueness: true
  validates :start_year_gregorian, numericality: true, allow_blank: true
  validates :end_year_gregorian, numericality: true, allow_blank: true
  validates :start_year_hijri, numericality: true, allow_blank: true
  validates :end_year_hijri, numericality: true, allow_blank: true
  has_and_belongs_to_many :documents
end
