# == Schema Information
#
# Table name: languages
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  is_rtl     :boolean
#

class Language < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :documents
  default_scope { order('name') }
end
