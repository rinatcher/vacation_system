require 'rails_helper'

RSpec.describe VacationRequestsController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) { attributes_for(:vacation_request, user_id: user.id) }
  let(:invalid_attributes) { attributes_for(:vacation_request, start_date: nil) }

  before do
    sign_in(user)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      vacation_request = FactoryBot.create(:vacation_request, user: user)
      get :show, params: { id: vacation_request.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new VacationRequest' do
        expect {
          post :create, params: { vacation_request: valid_attributes }
        }.to change(VacationRequest, :count).by(1)
      end

      it 'redirects to the created vacation_request' do
        post :create, params: { vacation_request: valid_attributes }
        expect(response).to redirect_to(vacation_requests_path)
      end
    end

    context 'with invalid parameters' do
      it 'returns a success response (i.e., to display the "new" template)' do
        post :create, params: { vacation_request: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      vacation_request = FactoryBot.create(:vacation_request, user: user)
      get :edit, params: { id: vacation_request.to_param }
      expect(response).to be_successful
    end
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      it 'updates the requested vacation_request' do
        vacation_request = FactoryBot.create(:vacation_request, user: user)
        put :update, params: { id: vacation_request.to_param, vacation_request: valid_attributes }
        vacation_request.reload
        expect(vacation_request.start_date).to eq(valid_attributes[:start_date])
      end

      it 'redirects to the vacation_request' do
        vacation_request = FactoryBot.create(:vacation_request, user: user)
        put :update, params: { id: vacation_request.to_param, vacation_request: valid_attributes }
        expect(response).to redirect_to(vacation_request_path(vacation_request))
      end
    end

    context 'with invalid parameters' do
      it 'returns a success response (i.e., to display the "edit" template)' do
        vacation_request = FactoryBot.create(:vacation_request, user: user)
        put :update, params: { id: vacation_request.to_param, vacation_request: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested vacation_request' do
      vacation_request = FactoryBot.create(:vacation_request, user: user)
      expect {
        delete :destroy, params: { id: vacation_request.to_param }
      }.to change(VacationRequest, :count).by(-1)
    end

    it 'redirects to the vacation_requests list' do
      vacation_request = FactoryBot.create(:vacation_request, user: user)
      delete :destroy, params: { id: vacation_request.to_param }
      expect(response).to redirect_to(vacation_requests_path)
    end
  end
end
