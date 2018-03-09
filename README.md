Overview
=====
This project serves a few purposes: 

* Provide a few useful tools to a small county sheriff's office
* Further my own web development education
* Demonstrate a part of my skillset

So far it has accomplished the second admirably, the first adequately, and if
you're reading this I have high hopes for the third as well. This website,
like me, is certainly not finished growing, but it has come a long way from 
the beginning. It went live in mid-January, and is in active use by 
approximately 20 people. 


This small sheriff's office has an Auxiliary officer program, composed of 
volunteers who go through much of the same training and certification as 
full-time deputies. The department needed a way for these volunteers to log 
their time, in order to justify funding decisions and provide oversight of the 
program as a whole, a single location to host all computer and web based 
training, and a way to track completion of that training. 

Currently, Timecard tracking is basically complete and is the main use case for 
the site. Training is mostly done, but a few critical features are still
required before they can use it extensively. 

Features
=====
* Complete user login/logout/registration system.
* Administrator approval of new users.
* User roles and permissions, with 3 distinct roles.
* Administration interface, allowing those with sufficient roles to view and
  modify user details.
* Deactivation of users, allowing their records to be saved while not allowing
  them to log in or displaying their records (unless sought out specifically). 
* Complete CRUD functionality for timecards, with strong validations and a
  convenient, easy to use form to enter them.
* Administration interface, allowing users with sufficient roles to filter and 
  view timecards in a few different ways.
* Front page bulletins, with markdown formatting. 
* CRUD interface for training videos. Training videos are embedded from YouTube.
* Role-based display of training completion for various users.   


Foundation
======

* Rails 5

* Bootstrap 4

* PostgreSQL

* Heroku, MailGun

Important Gems
====
* Devise

* Pundit

* Redcarpet

* Capybara

Other information
=====
The database seed file contains only test data. If you'd like to play with the
site, clone it, setup and seed the database, and boot the server. Test logins
are `admin`, `trainer`, `deputy`, and `pending@example.com`, and the passwords for all
are `123456`.

Conclusion
====
When you follow tutorials online, there is a lot of imagination and hand-waving 
around inconvenient details, but here I couldn't do that. I've had to jump 
through hoops on the back end to ensure the front end behaves in a way that is 
best for the user, not for the developer. 

The purpose of all this isn't to show how much I know, it's to show how much I
can learn. 
