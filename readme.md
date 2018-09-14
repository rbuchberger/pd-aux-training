Overview
=====
This project serves a few purposes: 

* Provide a few useful tools to a small county sheriff's office
* Further my own web development education
* Demonstrate a part of my skillset

So far it has accomplished the second admirably, the first adequately, and if
you're reading this I have high hopes for the third as well. It went live in
mid-January, and is in active use by approximately 20 people. 

This small Sheriff's office has an Auxiliary officer program, composed of
volunteers who go through much of the same training and certification as
full-time deputies. The department needed a way for these volunteers to log
their time, in order to justify funding decisions and provide oversight of the
program as a whole. They also needed a single location to host all computer and
web based training, a way to track completion of that training, a central
bulletin board to post information, and a document library to distribute
training materials.  All of this information should only be presented to
authenticated, authorized users. 

Features
=====
* Complete user login/logout/registration system.
* Administrator approval of new users.
* User roles and permissions.
* Administration interface, allowing those with sufficient roles to view and
  modify user details, timecards, documents, and training items.
* Deactivation of users, allowing their records to be saved while not allowing
  them to log in or displaying their records (unless sought out specifically). 
* Complete CRUD functionality for timecards, with strong validations and a
  convenient, easy to use form to enter them.
* Front page bulletins, with markdown formatting. 

Foundation
======

* Rails 5

* Bootstrap 4

* PostgreSQL

* Heroku, MailGun

* AWS S3 (Hosting the document library)

Important Gems
====
* Devise

* Pundit

* Redcarpet

* Capybara

Conclusion
====
When you follow tutorials online, there is a lot of imagination and hand-waving 
around inconvenient details, but here I couldn't do that. I've had to jump 
through hoops on the back end to ensure the front end behaves in a way that is 
best for the user, not for the developer. 
