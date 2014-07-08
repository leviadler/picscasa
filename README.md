# PicsCasa
##### a home for your pics

[PicsCasa](http://www.picscasa.com) is an [Picasa](http://www.picasaweb.google.com) clone. It was built by [Levi Adler](http://www.leviadler.com) using Ruby on Rails along with Backbone.js and other jQuery and Javascript features. All pages were hand-styled. 

You can visit the live version at [PicsCasa.com](http://www.picscasa.com) - click on the "Demo user" button if you just want to check it out!

## Features

PicsCasa features the core functionality of picasa. Users can:

* Create Albums
* Upload pictures
* Comment, tag, like and add captions to pictures
* View other public albums and like or comment on their pictures
* Unlisted Albums - albums that can only be viewed by others if you send them a special encrypted link
* Users do not need to be logged in to view public or unlisted albums

## Technologies Used

Various technologies were utilized to make PicsCasa work in the amazing way that it does. Here are some of them:

* **Back-End:** PicsCasa has a Rails 4.1 back-end with a RESTful API.
  * Oauth for Google sign in
  * Uploading of pictures using Paperclip and ImageMagick
  * Mailer to email shared albums to friends
* **Front-End:** PicsCasa has a Backbone.js front-end to provide a smoother user experience and minimize requests to the server.
  * Overwrites parse method in Backbone photo and album models
  * Builds custom JSON using Jbuilder
  * Bootstaps initial data to minimize lag and Ajax requests
  * Prevents duplicate data using Subsets (a extension of Backbone Collection)
* **Styling:** PicsCasa was styled with custom CSS without the use of any third-party themes or tools.


## Still To Do

* Allow drag and drop photo upload
* Set up a mailer to confirm email addresses
* Pagination using Kaminari with infinate scroll
* Organize order of pictures useing JQueryUI
* Add the ability for users to reset passwords
* Backbonify the Polymorphic Notification