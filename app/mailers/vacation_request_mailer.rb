# frozen_string_literal: true

class VacationRequestMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.vacation_request_mailer.new_request_email.subject
  #
  def new_request_email(user, request)
    @user = user
    @vacation_request = request

    mail(
      to: @user.email,
      subject:
        "Заявка на даты: #{@vacation_request.start_date.strftime('%d.%m.%Y')} - #{@vacation_request.end_date.strftime('%d.%m.%Y')}"
    )
  end
end
