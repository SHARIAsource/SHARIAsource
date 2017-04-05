# == Schema Information
#
# Table name: users
#
#  id                         :integer          not null, primary key
#  email                      :string(255)      default(""), not null
#  encrypted_password         :string(255)      default(""), not null
#  reset_password_token       :string(255)
#  reset_password_sent_at     :datetime
#  remember_created_at        :datetime
#  sign_in_count              :integer          default(0), not null
#  current_sign_in_at         :datetime
#  last_sign_in_at            :datetime
#  current_sign_in_ip         :string(255)
#  last_sign_in_ip            :string(255)
#  created_at                 :datetime
#  updated_at                 :datetime
#  is_editor                  :boolean          default(FALSE)
#  first_name                 :string(255)
#  last_name                  :string(255)
#  last_name_without_articles :string(255)
#  collaborator_id            :integer
#  parent_id                  :integer
#  about                      :text
#  avatar                     :string(255)
#  requires_approval          :boolean          default(FALSE)
#  disabled                   :boolean
#  is_admin                   :boolean          default(FALSE)
#

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
