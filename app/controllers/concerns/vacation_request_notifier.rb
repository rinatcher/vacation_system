# frozen_string_literal: true

module VacationRequestNotifier
  extend ActiveSupport::Concern

  included do
    after_action :notify_users, only: %i[create update]
  end

  private

  def notify_users
    return unless @vacation_request.persisted?

    User.where(id: @vacation_request.user_id).each do |user|
      VacationRequestMailer.new_request_email(user, @vacation_request).deliver_later
    end
  end
end
