# == Schema Information
#
# Table name: themes
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  archived   :boolean          default(FALSE)
#

class Theme < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_and_belongs_to_many :documents
  default_scope { order(:name) }
end
