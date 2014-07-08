class Collaborator < ActiveRecord::Base
  validates :name, presence: true
end
