# == Schema Information
#
# Table name: bodies
#
#  id        :integer          not null, primary key
#  text      :text
#  static_id :integer
#

describe Body do
  it { should respond_to :text }
  it { should belong_to :static }
end
