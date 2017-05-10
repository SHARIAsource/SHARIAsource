require 'rails_helper'

describe Body do
  it { should respond_to :text }
  it { should belong_to :page }
  it { should belong_to :document }
end
