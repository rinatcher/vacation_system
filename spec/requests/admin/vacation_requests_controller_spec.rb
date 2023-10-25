# spec/controllers/admin/vacation_requests_controller_spec.rb
require 'rails_helper'

RSpec.describe Admin::VacationRequestsController, type: :controller do
  let(:admin) { create(:user, role: :admin) }
  let(:user) { create(:user) }

  before do
    sign_in(admin)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      vacation_request = create(:vacation_request, user: user)
      get :show, params: { id: vacation_request.to_param }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    context 'when updating status to "approved"' do
      it 'updates the requested vacation_request status' do
        vacation_request = create(:vacation_request, user: user, status: :pending)
        patch :update, params: { id: vacation_request.to_param, status: 'approved' }
        vacation_request.reload
        expect(vacation_request.status).to eq('approved')
      end

      it 'redirects to the vacation_request' do
        vacation_request = create(:vacation_request, user: user, status: :pending)
        patch :update, params: { id: vacation_request.to_param, status: 'approved' }
        expect(response).to redirect_to(admin_vacation_request_path(vacation_request))
      end
    end

    context 'when updating status to "rejected"' do
      it 'updates the requested vacation_request status' do
        vacation_request = create(:vacation_request, user: user, status: :pending)
        patch :update, params: { id: vacation_request.to_param, status: 'rejected' }
        vacation_request.reload
        expect(vacation_request.status).to eq('rejected')
      end

      it 'redirects to the vacation_request' do
        vacation_request = create(:vacation_request, user: user, status: :pending)
        patch :update, params: { id: vacation_request.to_param, status: 'rejected' }
        expect(response).to redirect_to(admin_vacation_request_path(vacation_request))
      end
    end
  end
end
