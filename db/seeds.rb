name = "alien"
email = "a@a.com"
password = "111111"
User.create!(name: name,
             email: email,
             password: password,
             password_confirmation: password,
             admin: true
             )

9.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password,
              admin: false
              )
end
            
Label.create!(
  [
    {name: 'Zelda'},
    {name: 'Final Fantasy'},
    {name: 'Dragon Quest'},
    {name: 'Splatoon'},
    {name: 'Bullet Voyage'},
    {name: 'Among Us'},
    {name: 'Mini Metro'},
    {name: 'Mario Odessay'},
    {name: 'Mario World'},
    {name: 'Star Ocean'}
  ]
)

10.times do |n|
  title = Faker::Games::Pokemon.move
  content = Faker::Games::Pokemon.location
  expired_at = Faker::Date.between(from: '2021-05-27', to: '2021-09-27')
  user_id = n + 1
  Task.create!(title: title,
               content: content,
               expired_at: expired_at,
               user_id: user_id
               )
end