# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Movie.destroy_all
Party.destroy_all
Guest.destroy_all

user = User.create!(name: "Tim", email: "tim@gmail.com", password: "test")
harry_potter = Movie.create!({title: "Harry Potter and the Philosopher's Stone", duration: 152, api_id: 671})
hp_watch_party = user.parties.create!({movie_id: harry_potter.id, date: DateTime.now.to_date.to_s, start_time: DateTime.now.to_time.to_s[11..15], duration: 152 })
guest = user.guests.create!({party_id: hp_watch_party.id})
