name = "takuya"
email = "takuy@gmail.com"
password = "takuya"
User.create!(name: name,
            email: email,
            password: password,
            password_confirmation: password,
            admin: true
            )

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