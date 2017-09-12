require 'rails_helper'

describe Language do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should have_many :documents }
  it { should respond_to :is_rtl }
  it { should respond_to :sort_order }
end
