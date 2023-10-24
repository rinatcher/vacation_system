# frozen_string_literal: true

module Admin
  class VacationRequestsController < ApplicationController
    before_action :set_vacation, only: %i[show update]
    helper_method :user_name

    def index
      @vacation_requests = VacationRequest.paginate(page: params[:page], per_page: 3)
                                          .order(created_at: :desc)
    end

    def show; end

    def update
      @vacation_request.update(vacation_params)
      flash[:notice] = if @vacation_request.status == 'approved'
                         'Заявка подтверждена'
                       else
                         'Заявка отклонена'
                       end
      redirect_to admin_vacation_request_path
    end

    def user_name(user)
      User.where(id: user).pick(:name)
    end

    private

    def set_vacation
      @vacation_request = VacationRequest.find(params[:id])
    end

    def vacation_params
      params.permit(:status)
    end
  end
end
