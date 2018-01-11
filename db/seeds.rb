# These seeds are for testing purposes only. 

User.create([
  {
    first_name: 'Austin',
    last_name: 'Powers',
    badge_number: '701',
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
  } , {
    first_name: 'Number',
    last_name: 'Two', 
    badge_number: 'N/A',
    email: 'deactivated@example.com',
    role: :deputy,
    password: '123456',
    deleted_at: Time.zone.now - 1.day
  } 

])
  
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
    title: "How to apply handcuffs", 
    description: "I know someone who's into this stuff.", 
    url: "https://www.youtube.com/watch?v=PdDu9T1EbWM", 
  } , {
    title: "The Ultimate Hickok45 Montage",
    description: "Hickock45 here, smokin' some pot.",
    url: "https://www.youtube.com/watch?v=3VHTUG-VpWA&index=3&list=FLcGBJ-rifHsKrhvwmmX4VCw",
  } , {
    title: "Handgun selection",
    description: "",
    url: "https://www.youtube.com/watch?v=-OSodRtHHmo&index=5&list=FLcGBJ-rifHsKrhvwmmX4VCw",
  }
])

TrainingRecord.create([
  {
    user_id: 3,
    training_video_id: 2
  } , {
    user_id: 3,
    training_video_id: 1
  } , {
    user_id: 3,
    training_video_id: 3
  } , {
    user_id: 1,
    training_video_id: 2
  } , {
    user_id: 1,
    training_video_id: 3
  } , {
    user_id: 2,
    training_video_id: 1
  } 
])
