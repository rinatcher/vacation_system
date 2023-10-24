class AddUserRefToVacationRequests < ActiveRecord::Migration[7.0]
  def change
    add_reference :vacation_requests, :user, null: false, foreign_key: true
  end
end
