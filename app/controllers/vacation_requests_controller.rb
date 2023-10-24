# frozen_string_literal: true

class VacationRequestsController < ApplicationController
  include VacationRequestNotifier
  before_action :set_vacation, only: %i[edit update show destroy]
  helper_method :pending?

  def index
    @vacation_requests = VacationRequest.where(user_id: current_user.id)
                                        .paginate(page: params[:page], per_page: 3)
                                        .order(created_at: :desc)
  end

  def show; end

  def new
    @vacation_request = VacationRequest.new
  end

  def edit; end

  def create
    @vacation_request = VacationRequest.new(vacation_params)
    @vacation_request.user_id = current_user.id
    if @vacation_request.save
      flash[:notice] = 'Заявка отправлена! Ожидайте подтверждения'
      redirect_to vacation_requests_path
    else
      flash[:alert] = 'Неверно введены данные'
      render :new
    end
  end

  def update
    if @vacation_request.update(vacation_params)
      flash[:notice] = 'Заявка изменена'
      redirect_to vacation_request_path
    else
      flash[:alert] = 'Что-то пошло не так...'
      render :edit
    end
  end

  def destroy
    @vacation_request.destroy
    flash[:notice] = 'Заявка удалена'
    redirect_to vacation_requests_path
  end

  def pending?
    @vacation_request.status == 'pending'
  end

  private

  def set_vacation
    @vacation_request = VacationRequest.find(params[:id])
  end

  def vacation_params
    params.require(:vacation_request).permit(:start_date, :end_date, :comment, :user_id)
  end
end

