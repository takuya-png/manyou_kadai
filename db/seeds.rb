name = "takuya"
email = "takuy@gmail.com"
password = "takuya"
User.create!(name: name,
            email: email,
            password: password,
            password_confirmation: password,
            admin: true
            )

Label.create([
  { name: '喜' },
  { name: '怒' },
  { name: '哀'},
  { name: '楽'},
  ])