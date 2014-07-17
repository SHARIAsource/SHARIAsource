# == Schema Information
#
# Table name: users
#
#  id                         :integer          not null, primary key
#  email                      :string(255)      default(""), not null
#  encrypted_password         :string(255)      default(""), not null
#  reset_password_token       :string(255)
#  reset_password_sent_at     :datetime
#  remember_created_at        :datetime
#  sign_in_count              :integer          default(0), not null
#  current_sign_in_at         :datetime
#  last_sign_in_at            :datetime
#  current_sign_in_ip         :string(255)
#  last_sign_in_ip            :string(255)
#  created_at                 :datetime
#  updated_at                 :datetime
#  is_admin                   :boolean          default(FALSE)
#  is_editor                  :boolean          default(FALSE)
#  is_contributor             :boolean          default(FALSE)
#  first_name                 :string(255)
#  last_name                  :string(255)
#  last_name_without_articles :string(255)
#

describe User do
  it { should respond_to :is_admin? }
  it { should respond_to :is_editor? }
  it { should respond_to :is_contributor? }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should belong_to :collaborator }

  describe 'last_name_without_articles' do
    before :each do
      @user = create :user, last_name: 'Al Doe'
    end

    it 'removes articles' do
      expect(@user.last_name_without_articles).to eq 'Doe'
    end
  end
end
