class CreateVacationRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :vacation_requests do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :status, default: 0
      t.string :comment
      t.timestamps
    end
  end
end
