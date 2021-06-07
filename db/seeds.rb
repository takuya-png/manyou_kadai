name = "takuya"
email = "takuy@gmail.com"
password = "takuya"
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
               {name: 'HTML'},
               {name: 'CSS'},
               {name: 'Javascript'},
               {name: 'Ruby'},
               {name: 'Ruby on Rails'},
               {name: 'Git/GitHub'},
               {name: '課題'},
               {name: 'グループワーク'},
               {name: 'ブレスト'},
               {name: '卒業課題'}
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
                           user_id: user_id,
                           )
            end