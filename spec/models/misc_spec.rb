require 'rails_helper'

describe Misc do
  it { should validate_presence_of :slug }
  it { should validate_uniqueness_of :slug }
  it { should validate_presence_of :title }
  it { should respond_to :body }
end
