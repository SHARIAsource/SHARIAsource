# == Schema Information
#
# Table name: pages
#
#  id          :integer          not null, primary key
#  image       :string(255)
#  document_id :integer
#  number      :integer
#

class Page < ActiveRecord::Base
  validates :number, numericality: { greater_than: 0 }
  has_one :body, dependent: :destroy
  belongs_to :document
  mount_uploader :image, ImageUploader
  accepts_nested_attributes_for :body
  default_scope { order('number') }
end
