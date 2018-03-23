class ProjectsUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates :sort_order, :presence => true
end
