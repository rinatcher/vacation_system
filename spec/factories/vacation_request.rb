FactoryBot.define do
  factory :vacation_request do
    start_date { Date.tomorrow }
    end_date { Date.tomorrow + 1 }
    status { :pending }
    user
  end
end
