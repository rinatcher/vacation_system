require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe 'associations' do
    it { should have_many(:vacation_requests) }
  end

  describe 'defaults' do
    it 'has a default role of "user"' do
      user = FactoryBot.create(:user)
      expect(user.role).to eq('user')
    end
  end
end
