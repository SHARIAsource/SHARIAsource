# == Schema Information
#
# Table name: pages
#
#  id        :integer          not null, primary key
#  image     :string(255)
#  source_id :integer
#

class Page < ActiveRecord::Base
  has_one :body, dependent: :destroy
  belongs_to :source
  mount_uploader :image, ImageUploader
  accepts_nested_attributes_for :body
end
