# == Schema Information
#
# Table name: bodies
#
#  id            :integer          not null, primary key
#  text          :text
#  page_id       :integer
#  commentary_id :integer
#  document_id   :integer
#

class Body < ActiveRecord::Base
  belongs_to :page
  belongs_to :document
end
