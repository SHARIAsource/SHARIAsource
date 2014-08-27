# == Schema Information
#
# Table name: documents
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  document_type_id   :integer
#  pdf                :string(255)
#  processed          :boolean          default(TRUE)
#  gregorian_date     :date
#  lunar_hijri_date   :date
#  source_name        :string(255)
#  source_url         :string(255)
#  author             :string(255)
#  translators        :string(255)
#  editors            :string(255)
#  publisher          :string(255)
#  publisher_location :string(255)
#  volume_count       :integer
#  alternate_titles   :string(255)
#  alternate_authors  :string(255)
#  language_id        :integer
#  contributor_id     :integer
#  popular_count      :integer          default(0)
#  created_at         :datetime
#  updated_at         :datetime
#  featured_position  :integer
#

describe Document do
  it { should validate_presence_of :title }
  it { should validate_presence_of :contributor_id }
  it { should validate_presence_of :document_type_id }
  it { should validate_numericality_of :popular_count }
  it { should ensure_inclusion_of(:featured_position)
    .in_range(1..3)
    .with_message('Must be between 1 and 3') }

  it { should respond_to :pdf }
  it { should respond_to :gregorian_date }
  it { should respond_to :lunar_hijri_date }
  it { should respond_to :source_name }
  it { should respond_to :source_url }
  it { should respond_to :author }
  it { should respond_to :translators }
  it { should respond_to :editors }
  it { should respond_to :publisher }
  it { should respond_to :publisher_location }
  it { should respond_to :volume_count }
  it { should respond_to :alternate_titles }
  it { should respond_to :alternate_authors }
  it { should respond_to :popular_count }

  it { should have_and_belong_to_many :themes }
  it { should have_and_belong_to_many :topics }
  it { should have_and_belong_to_many :tags }
  it { should have_and_belong_to_many :eras }
  it { should have_and_belong_to_many :regions }
  it { should have_and_belong_to_many :referenced_documents }
  it { should have_many(:pages).dependent :destroy }
  it { should have_one :body }
  it { should belong_to :document_type }
  it { should belong_to :reference_type }
  it { should belong_to :language }
  it { should belong_to :contributor }

  it { should accept_nested_attributes_for :pages }
  it { should accept_nested_attributes_for :body }

  it 'adds http:// to source urls that do not have it' do
    document = create :document, source_url: 'www.example.org'
    document.reload
    expect(document.source_url).to eq 'http://www.example.org'
  end
end
