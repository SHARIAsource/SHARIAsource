# == Schema Information
#
# Table name: languages
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  is_rtl     :boolean
#  sort_order :integer
#

class Language < ActiveRecord::Base
  include RankedModel

  validates :name, presence: true, uniqueness: true
  has_many :documents
  ranks :sort_order
end
