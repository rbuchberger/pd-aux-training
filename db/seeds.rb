# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([
  {
    first_name: 'Austin',
    last_name: 'Powers',
    badge_number: 'a01',
    email: 'admin@example.com',
    role: :admin,
    password: '123456',
    password_confirmation: '123456'
  } , {
    first_name: 'Vanessa',
    last_name: 'Kensington',
    badge_number: 'x01',
    email: 'trainer@example.com',
    role: :trainer,
    password: '123456',
    password_confirmation: '123456'
  } , {
    first_name: 'Scott',
    last_name: 'Evil',
    badge_number: 'x02',
    email: 'deputy@example.com',
    role: :deputy,
    password: '123456',
    password_confirmation: '123456'
  } , {
    first_name: 'Frau',
    last_name: 'Farbissina',
    badge_number: 'x03',
    email: 'pending@example.com',
    role: :pending,
    password: '123456',
    password_confirmation: '123456'
  } ])
  
  Timecard.create([
  {
    user_id: 1,
    description: 'Raiding Panties',
    start: Time.zone.now - 5.days,
    end: Time.zone.now - 5.days + 5.hours,
  } , {
    user_id: 1,
    description: 'Dealing with fembots',
    start: Time.zone.now - 4.days,
    end: Time.zone.now - 4.days + 3.hours,
  } , {
    user_id: 2,
    description: 'Spy stuff',
    start: Time.zone.now - 5.days,
    end: Time.zone.now - 5.days + 5.hours,
  } , {
    user_id: 3,
    description: 'Getting shushed' ,
    start: Time.zone.now - 31.days,
    end: Time.zone.now - 31.days + 9.hours,
  } , {
    user_id: 4,
    description: 'Bring in de femBOTS!',
    start: Time.zone.now - 10.days ,
    end: Time.zone.now - 10.days + 10.hours,
  } , {
    user_id: 1,
    description: 'Putting the GRRR in swinger baby',
    start: Time.zone.now - 7.days,
    end: Time.zone.now - 7.days + 12.hours,
  } , {
    user_id: 1,
    description: 'Retrieving Mojo',
    start: Time.zone.now - 3.days + 2.hours,
    end: Time.zone.now - 3.days + 9.hours,
  }
  ])
  
  TrainingVideo.create([
    {
      title: "Handcuffs", 
      description: "Small test video", 
      url: "https://www.youtube.com/watch?v=PdDu9T1EbWM", 
    } , {
      title: "The Ultimate Hickok45 Montage",
      description: "https://www.youtube.com/watch?v=3VHTUG-VpWA&index=3&list=FLcGBJ-rifHsKrhvwmmX4VCw",
      url: "Hickock45 here, smokin' some pot.",
    }
    ])