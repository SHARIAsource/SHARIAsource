class NamedFilter < ActiveRecord::Base
  belongs_to :language, required: false
  belongs_to :user, required: false
  belongs_to :topic, required: false
  belongs_to :theme, required: false
  belongs_to :region, required: false
  belongs_to :era, required: false
  belongs_to :document_type, required: false
  belongs_to :project, required: false
  has_and_belongs_to_many :named_filter_documents, class_name: 'Document',
    join_table: :named_filter_documents
  validates :name, presence: true

  alias :contributor :user

  attr_accessor :quick_create_url
end
