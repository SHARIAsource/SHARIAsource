# == Schema Information
#
# Table name: pages
#
#  id        :integer          not null, primary key
#  image     :string(255)
#  source_id :integer
#

describe Page do
  it { should respond_to :image }
  it { should have_one(:body).dependent(:destroy) }
  it { should belong_to :source }
  it { should accept_nested_attributes_for :body }
end
