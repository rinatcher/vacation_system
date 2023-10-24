# frozen_string_literal: true

class VacationRequestsController < ApplicationController
  before_action :set_vacation, only: %i[show]

  def index
    @vacation_requests = VacationRequest.paginate(page: params[:page], per_page: 5).order(created_at: :desc)
  end

  def show; end

  def new
    @vacation_request = VacationRequest.new
  end

  def create
    @vacation_request = VacationRequest.new(vacation_params)
    if @vacation_request.save
      flash[:notice] = 'Заявка отправлена! Ожидайте подтверждения'
      redirect_to vacation_requests_path
    else
      flash[:alert] = 'Неверно введены данные'
      render :new
    end
  end


  private

  def set_vacation
    @vacation_request = VacationRequest.find(params[:id])
  end

  def vacation_params
    params.require(:vacation_request).permit(:start_date, :end_date, :comment)
  end
end

