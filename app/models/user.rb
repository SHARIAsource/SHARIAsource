class User < ActiveRecord::Base
  include HasManyAttachedFiles

  ARTICLES_REGEX = /(Al[ |-]|El[ |-]\s*)/

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  before_save :remove_articles
  acts_as_tree name_column: 'last_name', order: 'last_name_without_articles'

  validates :first_name, presence: true
  validates :last_name, presence: true

  belongs_to :collaborator
  has_many :documents, foreign_key: 'contributor_id',
    dependent: :restrict_with_error

  has_many :projects_users
  has_many :projects, through: :projects_users

  # NOTE: Contributor was implemented first and it stole the 'has_many :documents' association
  has_many :uploaded_documents, foreign_key: 'user_id', class_name: 'Document',
    dependent: :restrict_with_error

  mount_uploader :avatar, ImageUploader
  default_scope { order('last_name_without_articles') }
  scope :editors, -> { where(is_editor: true) }
  scope :enabled, -> { where(disabled: false) }

  def can_edit?(document)
    is_editor? || self_and_descendant_ids.include?(document.contributor.id)
  end

  def can_review?
    is_admin? && is_editor?
  end

  def is_superuser?
    is_admin? && is_editor?
  end

  # This overrides Devise default implementation to disable accounts with
  # out custom disabled flag
  def active_for_authentication?
    super && !disabled?
  end

  def name
    "#{first_name} #{last_name}"
  end

  def is_superuser?
    # Short-hand method. Not really a term the business uses.
    is_admin? && is_editor?
  end

  def editor_id
    @_editor_id ||= (self.cb_editor_id || -> {
      api = Corpusbuilder::Ruby::Api.new
      editor = api.create_editor email: self.email,
        first_name: self.first_name,
        last_name: self.last_name
      self.update_attribute(:cb_editor_id, editor['id'])
      editor.id
    }.call)
  end

  def self.editors
    where(is_editor: true)
  end

  def self.enabled
    where(disabled: false)
  end

  private

  def remove_articles
    self.last_name_without_articles = last_name.sub ARTICLES_REGEX, ''
  end
end
