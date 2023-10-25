class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { user: 0, admin: 1 }
  has_many :vacation_requests

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :user
  end
end
