class DocumentReview < ActiveRecord::Base

  belongs_to :document
  belongs_to :user

  validates :document, presence: true
  validates :user, presence: true

end
