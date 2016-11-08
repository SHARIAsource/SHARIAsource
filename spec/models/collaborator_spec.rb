require 'rails_helper'

# == Schema Information
#
# Table name: collaborators
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  url         :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  image       :string(255)
#  sort_order  :integer
#

describe Collaborator do
  it { should validate_presence_of :name }
  it { should respond_to :url }
  it { should respond_to :description }
  it { should respond_to :image }
  it { should respond_to :sort_order }
  it { should have_many :users }
end
