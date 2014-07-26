# == Schema Information
#
# Table name: bodies
#
#  id        :integer          not null, primary key
#  text      :text
#  static_id :integer
#

class Body < ActiveRecord::Base
  belongs_to :static
end
