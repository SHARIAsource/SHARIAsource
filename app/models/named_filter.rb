class NamedFilter < ActiveRecord::Base
  belongs_to :language, required: false
  belongs_to :contributor, foreign_key: :user_id, class_name: 'User', required: false
  belongs_to :topic, required: false
  belongs_to :theme, required: false
  belongs_to :region, required: false
  belongs_to :era, required: false
  belongs_to :document_type, required: false
  belongs_to :project, required: false

  validates :name, presence: true
end
