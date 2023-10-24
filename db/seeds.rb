User.create(
  name: 'Еникеев Ринат',
  email: 'admin@admin.com',
  password: '123456',
  password_confirmation: '123456',
  role: 1
)
user1 = User.create(
  name: 'Владимир Вист',
  email: 'vova@test.com',
  password: '123456',
  password_confirmation: '123456'
)
user2 = User.create(
  name: 'Иван Иванов',
  email: 'ivan@test.com',
  password: '123456',
  password_confirmation: '123456'
)

5.times do |i|
  VacationRequest.create(
    start_date: Date.today + i.week,
    end_date: Date.today + (i+1).week,
    comment: "Test comment #{i+1}",
    user_id: user1.id
  )
end

5.times do |i|
  VacationRequest.create(
    start_date: Date.today.next_month + i.week,
    end_date: Date.today.next_month + (i+1).week,
    user_id: user2.id
  )
end
