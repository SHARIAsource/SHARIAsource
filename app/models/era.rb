# == Schema Information
#
# Table name: eras
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  parent_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  start_year :integer
#  end_year   :integer
#

class Era < ActiveRecord::Base
  acts_as_tree order: { start_year_gregorian: :asc }
  validates :name, presence: true, uniqueness: true
  validates :start_year_gregorian, numericality: true, allow_blank: true
  validates :end_year_gregorian, numericality: true, allow_blank: true
  validates :start_year_hijri, numericality: true, allow_blank: true
  validates :end_year_hijri, numericality: true, allow_blank: true
  has_and_belongs_to_many :documents
end
