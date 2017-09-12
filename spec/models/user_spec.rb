require 'rails_helper'

describe User do
  it { should respond_to :is_editor? }
  it { should respond_to :requires_approval? }
  it { should respond_to :about }
  it { should respond_to :avatar }
  it { should respond_to :disabled? }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should belong_to :collaborator }
  it { should have_many :documents }

  it 'is a closure tree' do
    expect(User).to be_a_closure_tree
  end

  describe 'last_name_without_articles' do
    before :each do
      ['Al Doe', 'Al-Doe', 'El Doe', 'El-Doe'].each do |last_name|
        create :user, last_name: last_name
      end
    end

    it 'removes articles' do
      expect(User.all.pluck(:last_name_without_articles)).to eq ['Doe']*4
    end
  end

  describe 'name' do
    it 'combines first and last name' do
      user = build :user, first_name: 'John', last_name: 'Doe'
      expect(user.name).to eq 'John Doe'
    end
  end
end
