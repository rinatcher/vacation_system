# frozen_string_literal: true

class VacationRequest < ApplicationRecord
  belongs_to :user

  enum status: { pending: 0, approved: 1, rejected: 2 }
  validates :start_date, :end_date, presence: true
  validates :end_date, comparison: { greater_than: Date.today }
  validates :start_date, comparison: { less_than: :end_date }
end
