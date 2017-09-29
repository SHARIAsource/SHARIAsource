class NamedFilter < ActiveRecord::Base
  belongs_to :language, required: false
  belongs_to :user, required: false
  belongs_to :topic, required: false
  belongs_to :theme, required: false
  belongs_to :region, required: false
  belongs_to :era, required: false
  belongs_to :document_type, required: false
  belongs_to :project, required: false

  validates :name, presence: true

  alias :contributor :user
end
