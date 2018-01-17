# These seeds are for testing purposes only. 

User.create([
  {
    first_name: 'Austin',
    last_name: 'Powers',
    badge_number: '701',
    email: 'admin@example.com',
    role: :admin,
    password: '123456',
    password_confirmation: '123456',
    id: 1
  } , {
    first_name: 'Vanessa',
    last_name: 'Kensington',
    badge_number: 'x01',
    email: 'trainer@example.com',
    role: :trainer,
    password: '123456',
    password_confirmation: '123456',
    id: 2
  } , {
    first_name: 'Scott',
    last_name: 'Evil',
    badge_number: 'x02',
    email: 'deputy@example.com',
    role: :deputy,
    password: '123456',
    password_confirmation: '123456',
    id: 3
  } , {
    first_name: 'Frau',
    last_name: 'Farbissina',
    badge_number: 'x03',
    email: 'pending@example.com',
    role: :pending,
    password: '123456',
    password_confirmation: '123456',
    id: 4
  } , {
    first_name: 'Number',
    last_name: 'Two', 
    badge_number: 'N/A',
    email: 'deactivated@example.com',
    role: :deputy,
    password: '123456',
    deleted_at: Time.zone.now - 1.day,
    id: 5
  } 

])
  
Timecard.create([
  {
    user_id: 1,
    description: 'Raiding Panties',
    clock_in: Time.zone.now - 5.days,
    clock_out: Time.zone.now - 5.days + 5.hours,
  } , {
    user_id: 1,
    description: 'Dealing with fembots',
    clock_in: Time.zone.now - 4.days,
    clock_out: Time.zone.now - 4.days + 3.hours,
  } , {
    user_id: 2,
    description: 'Spy stuff',
    clock_in: Time.zone.now - 5.days,
    clock_out: Time.zone.now - 5.days + 5.hours,
  } , {
    user_id: 3,
    description: 'Getting shushed' ,
    clock_in: Time.zone.now - 31.days,
    clock_out: Time.zone.now - 31.days + 9.hours,
  } , {
    user_id: 1,
    description: 'Putting the GRRR in swinger baby',
    clock_in: Time.zone.now - 7.days,
    clock_out: Time.zone.now - 7.days + 12.hours,
  } , {
    user_id: 1,
    description: 'Retrieving Mojo',
    clock_in: Time.zone.now - 3.days + 2.hours,
    clock_out: Time.zone.now - 3.days + 9.hours,
  }
])
  
Lesson.create([
  {
    id: 1,
    title: "How to apply handcuffs", 
    description: "I know someone who's into this stuff.",
    video_attributes: {
      url: "https://www.youtube.com/watch?v=PdDu9T1EbWM" 
    }
  } , {
    id: 2, 
    title: "The Ultimate Hickok45 Montage",
    description: "Hickock45 here, smokin' some pot.",
    video_attributes: {
      url: "https://www.youtube.com/watch?v=3VHTUG-VpWA&index=3&list=FLcGBJ-rifHsKrhvwmmX4VCw"
    }
  } , {
    id: 3,
    title: "Handgun selection",
    description: "",
    video_attributes: {
      url: "https://www.youtube.com/watch?v=-OSodRtHHmo&index=5&list=FLcGBJ-rifHsKrhvwmmX4VCw"
    }
  }
])

Completion.create([
  {
    user_id: 3,
    lesson_id: 2
  } , {
    user_id: 3,
    lesson_id: 1
  } , {
    user_id: 3,
    lesson_id: 3
  } , {
    user_id: 1,
    lesson_id: 2
  } , {
    user_id: 1,
    lesson_id: 3
  } , {
    user_id: 2,
    lesson_id: 1
  } 
])

Bulletin.create([
  {
    user_id: 1,
    title: "Watch out for fembots!",
    body: "We have new intelligence indicating that Dr. Evil has implemented machine-gun jublies with the newest models. Exercise extreme caution."
  } , {
    user_id: 2,
    title: "Don't worry about the fembots.",
    body: "They aren't real, austin is making things up. Trust me."
  } , {
    user_id: 1,
    title: "Pardon me for being rude.",
    body: "It was not me it was my food, it just popped up to say hello, but now it's gone back down below."
  }
])
