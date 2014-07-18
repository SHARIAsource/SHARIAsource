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
#  is_admin                   :boolean          default(FALSE)
#  is_editor                  :boolean          default(FALSE)
#  is_contributor             :boolean          default(FALSE)
#  first_name                 :string(255)
#  last_name                  :string(255)
#  last_name_without_articles :string(255)
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

  private
    def remove_articles
      self.last_name_without_articles = last_name.sub ARTICLES_REGEX, ''
    end
end
