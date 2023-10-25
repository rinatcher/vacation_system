require 'rails_helper'

RSpec.describe VacationRequest, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }

    it 'validates that end_date is greater than today' do
      request = FactoryBot.build(:vacation_request, end_date: Date.yesterday)
      request.valid?
      expect(request.errors[:end_date]).to include("must be greater than #{Date.today}")
    end

    it 'validates that start_date is less than end_date' do
      request = FactoryBot.build(:vacation_request, start_date: Date.tomorrow, end_date: Date.today)
      request.valid?
      expect(request.errors[:start_date]).to include("must be less than #{request.end_date}")
    end

    it { should define_enum_for(:status).with_values(%i[pending approved rejected]) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
