# == Schema Information
#
# Table name: bodies
#
#  id        :integer          not null, primary key
#  text      :text
#  static_id :integer
#  page_id   :integer
#  language  :string(255)
#

class Body < ActiveRecord::Base
  belongs_to :static
  belongs_to :page
  belongs_to :commentary
end
