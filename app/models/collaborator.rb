# == Schema Information
#
# Table name: collaborators
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  url         :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Collaborator < ActiveRecord::Base
  validates :name, presence: true
end
