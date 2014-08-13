# == Schema Information
#
# Table name: sources
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
#

describe Source do
  it { should validate_presence_of :title }
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

  it { should have_and_belong_to_many :themes }
  it { should have_and_belong_to_many :topics }
  it { should have_and_belong_to_many :tags }
  it { should have_and_belong_to_many :eras }
  it { should have_and_belong_to_many :reference_types }
  it { should have_and_belong_to_many :regions }
  it { should have_and_belong_to_many :referenced_sources }
  it { should have_many(:pages).dependent :destroy }
  it { should belong_to :document_type }
  it { should belong_to :language }
  it { should belong_to :contributor }

  it { should accept_nested_attributes_for :pages }

  it 'adds http:// to source urls that does not have it' do
    source = create :source, source_url: 'www.example.org'
    source.reload
    expect(source.source_url).to eq 'http://www.example.org'
  end
end
