# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

john = User.create(
  first_name: 'John',
  last_name: "O'Hagen",
  badge_number: 'a01',
  email: 'admin@example.com',
  role: :admin,
  password: '123456',
  password_confirmation: '123456'
  )
john.save!

thorny = User.create(
  first_name: 'Thorny',
  last_name: 'Ramathorn',
  badge_number: 'x01',
  email: 'trainer@example.com',
  role: :trainer,
  password: '123456',
  password_confirmation: '123456'
  )
thorny.save!

rabbit = User.create(
  first_name: 'Rabbit',
  last_name: 'Roto',
  badge_number: 'x02',
  email: 'deputy@example.com',
  role: :deputy,
  password: '123456',
  password_confirmation: '123456'
  )
rabbit.save!

farva = User.create(
  first_name: 'Rod',
  last_name: 'Farva',
  badge_number: 'x03',
  email: 'pending@example.com',
  role: :pending,
  password: '123456',
  password_confirmation: '123456'
  )
farva.save!