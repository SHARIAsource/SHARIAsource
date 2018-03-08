require 'rails_helper'

describe Document do
  it { should validate_presence_of :title }
  it { should validate_presence_of :contributor_id }
  it { should validate_presence_of :document_type_id }
  it { should validate_presence_of :language_id }
  it { should validate_inclusion_of(:document_style).in_array(
    %w(scan noscan scannotext)
  )}
  it { should validate_numericality_of :popular_count }
  it { should validate_numericality_of(:gregorian_year).allow_nil }
  it { should validate_numericality_of(:gregorian_month).allow_nil }
  it { should validate_numericality_of(:gregorian_day).allow_nil }
  it { should validate_inclusion_of(:featured_position)
    .in_range(1..3)
    .with_message('Must be between 1 and 3') }

  it { should respond_to :pdf }
  it { should respond_to :gregorian_date }
  it { should respond_to :lunar_hijri_date }
  it { should respond_to :lunar_hijri_year }
  it { should respond_to :lunar_hijri_month }
  it { should respond_to :lunar_hijri_day }
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
  it { should respond_to :permission_giver }
  it { should respond_to :published }
  it { should respond_to :published_at }
  it { should respond_to :alternate_editors }
  it { should respond_to :alternate_translators }
  it { should respond_to :alternate_years }
  it { should respond_to :summary }
  it { should respond_to :citation }

  it { should have_and_belong_to_many :themes }
  it { should have_and_belong_to_many :topics }
  it { should have_and_belong_to_many :tags }
  it { should have_and_belong_to_many :eras }
  it { should have_and_belong_to_many :regions }
  it { should have_and_belong_to_many :referenced_documents }
  it { should have_and_belong_to_many :referencing_documents }
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

  describe '#log_review' do

    let(:user) { create(:user) }

    context 'a not-reviewed document gets flagged as reviewed' do
      it 'creates a DocumentReview object' do
        user = create(:user)
        document = create(:document)

        document.reviewing_user = user
        expect {
          document.update! reviewed: true
        }.to change { document.reload.document_reviews.count }.by(1)
      end
    end

    context 'a reviewed document gets flagged as not-reviewed' do
      it 'does not create a DocumentReview object' do
        document = create(:document, reviewed: true, reviewing_user: user)

        expect {
          document.update! reviewed: false
        }.to change { document.reload.document_reviews.count }.by(0)
      end
    end

    context 'a not-reviewed document stays not-reviewed' do
      it 'does not create a DocumentReview object' do
        document = create(:document)

        expect {
          document.update! reviewed: false
        }.to change { document.reload.document_reviews.count }.by(0)
      end
    end

    context 'a reviewed document stays reviewed' do
      it 'does not create a DocumentReview object'  do
        document = create(:document, reviewed: true, reviewing_user: user)

        expect {
          document.update! reviewed: true
        }.to change { document.reload.document_reviews.count }.by(0)
      end
    end

  end

end
