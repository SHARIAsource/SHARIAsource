# == Schema Information
#
# Table name: bodies
#
#  id        :integer          not null, primary key
#  text      :text
#  static_id :integer
#  page_id   :integer
#  language  :string(255)
#

describe Body do
  it { should respond_to :text }
  it { should belong_to :static }
  it { should belong_to :page }
  it { should belong_to :commentary }
end
