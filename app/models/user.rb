class User < ActiveRecord::Base
  include HasManyAttachedFiles

  ARTICLES_REGEX = /(Al[ |-]|El[ |-]\s*)/

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  before_save :remove_articles
  before_save :clear_contributor_cache
  # before_save :default_values

  acts_as_tree name_column: 'last_name', order: 'last_name_without_articles'

  validates :first_name, presence: true
  validates :last_name, presence: true

  belongs_to :collaborator
  has_one :author
  has_and_belongs_to_many :documents,
           foreign_key: 'contributor_id',
           join_table: :contributors_documents,
           dependent: :restrict_with_error

  has_many :projects_users, dependent: :destroy
  has_many :projects, through: :projects_users
  belongs_to :role

  # NOTE: Contributor was implemented first and it stole the 'has_many :documents' association
  has_many :uploaded_documents, foreign_key: 'user_id', class_name: 'Document',
    dependent: :restrict_with_error

  mount_uploader :avatar, ImageUploader
  default_scope { order('last_name_without_articles') }
  scope :editors, -> { where(is_editor: true) }
  scope :enabled, -> { where(disabled: false) }

  def can_edit?(object)
    if object.is_a? Document
      return is_editor? || self_and_descendant_ids.include?(object.contributor.id)
    elsif object.is_a? Project
      return is_admin || object.users.include?(self)
    end

    false
  end

  def update_author(author)
    Author.where(user_id: self.id).update_all(user_id: nil)
    author.update_attribute(:user_id, self.id) if author
  end

  def author_id
    self.author.try(:id)
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

  def name_with_role
    "#{first_name} #{last_name}, #{role_title}"
  end

  def role_and_term
    s = " "
    if role
      s += role_title
    end
    if(term_start_year || term_end_year)
      s += ", "
    end
    if(term_start_year)
      s += term_start_year.to_s
    end
    if(term_end_year)
      s += "-" + term_end_year.to_s
    end
    s
  end

  def is_superuser?
    # Short-hand method. Not really a term the business uses.
    is_admin? && is_editor?
  end

  def self.editors
    where(is_editor: true)
  end

  def self.enabled
    where(disabled: false)
  end

  def role_title
    role = Role.find(role_id)
    role.title 
  end

  private

  def remove_articles
    self.last_name_without_articles = last_name.sub ARTICLES_REGEX, ''
  end

  def clear_contributor_cache
    Rails.cache.delete 'document_type_contributor_counts'
  end

  # def default_values
  #   # Was trying to use this for setting avatar; instead set a default_url in image_uploader.rb https://github.com/carrierwaveuploader/carrierwave#providing-a-default-url
  #   puts 'DEFAULT VALUES'
  #   puts self.avatar
  # end
end
