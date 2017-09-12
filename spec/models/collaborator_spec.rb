require 'rails_helper'

describe Collaborator do
  it { should validate_presence_of :name }
  it { should respond_to :url }
  it { should respond_to :description }
  it { should respond_to :image }
  it { should respond_to :sort_order }
  it { should have_many :users }
end
