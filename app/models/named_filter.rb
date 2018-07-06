class NamedFilter < ActiveRecord::Base
  belongs_to :language, required: false
  belongs_to :user, required: false
  belongs_to :topic, required: false
  belongs_to :theme, required: false
  belongs_to :region, required: false
  belongs_to :era, required: false
  belongs_to :document_type, required: false
  belongs_to :project, required: false
  belongs_to :parent, class_name: 'NamedFilter'
  has_many :children, class_name: 'NamedFilter', foreign_key: 'parent_id'
  has_and_belongs_to_many :named_filter_documents, class_name: 'Document',
    join_table: :named_filter_documents
  has_and_belongs_to_many :named_filter_additional_documents, class_name: 'Document',
    join_table: :named_filter_additional_documents
  has_and_belongs_to_many :named_filter_excluded_documents, class_name: 'Document',
    join_table: :named_filter_excluded_documents
  validates :name, presence: true

  alias :contributor :user

  attr_accessor :quick_create_url

  default_scope { order('priority asc') }

end
