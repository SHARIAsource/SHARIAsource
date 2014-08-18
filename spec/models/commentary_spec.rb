# == Schema Information
#
# Table name: commentaries
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  contributor_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

describe Commentary do
  it { should validate_presence_of :title }
  it { should validate_presence_of :contributor_id }
  it { should validate_numericality_of :popular_count }
  it { should ensure_inclusion_of(:featured_position)
    .in_range(1..3)
    .with_message('Must be between 1 and 3') }
  it { should belong_to :contributor }
  it { should have_one :body }
  it { should have_and_belong_to_many :sources }
  it { should accept_nested_attributes_for :body }
end
