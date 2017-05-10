class User < ActiveRecord::Base
  ARTICLES_REGEX = /(Al[ |-]|El[ |-]\s*)/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  before_save :remove_articles
  acts_as_tree name_column: 'last_name', order: 'last_name_without_articles'

  validates :first_name, presence: true
  validates :last_name, presence: true

  belongs_to :collaborator
  has_many :documents, foreign_key: 'contributor_id',
    dependent: :restrict_with_error

  mount_uploader :avatar, ImageUploader
  default_scope { order('last_name_without_articles') }

  def can_edit?(document)
    is_editor? || self_and_descendant_ids.include?(document.contributor.id)
  end

  # This overrides Devise default implementation to disable accounts with
  # out custom disabled flag
  def active_for_authentication?
    super && !disabled?
  end

  def name
    "#{first_name} #{last_name}"
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
