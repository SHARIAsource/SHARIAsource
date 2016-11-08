require 'rails_helper'

# == Schema Information
#
# Table name: miscs
#
#  id         :integer          not null, primary key
#  slug       :string(255)
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  body       :text
#

describe Misc do
  it { should validate_presence_of :slug }
  it { should validate_uniqueness_of :slug }
  it { should validate_presence_of :title }
  it { should respond_to :body }
end
