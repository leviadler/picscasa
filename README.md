# PicsCasa
##### a home for your pics

[PicsCasa](http://www.picscasa.com) is an [Picasa](http://www.picasaweb.google.com) clone. It was built by [Levi Adler](http://www.leviadler.com) using Ruby on Rails along with Backbone.js and other jQuery and Javascript features. All pages were hand-styled.

## Features

PicsCasa features the core functionality of picasa. Users can:

* Create Albums
* Upload pictures
* Comment, tag, like and add captions to pictures
* View other public albums and like or comment on their pictures
* Unlisted Albums - albums that can only be viewed by others if you send them a special encrypted link

## Technologies Used

Various technologies were utilized to make PicsCasa work in the amazing way that it does. Here are some of them:

* Oauth for Google sign in
* Uploading of pictures using Paperclip and ImageMagick
* Mailer to email shared albums to friends
* One page app using Backbone.js with changes updating in realtime. 
  * Overwrites parse method in Backbone photo and album models
  * Builds custom JSON using Jbuilder
  * Bootstaps initial data to minimize lag and Ajax requests
  * Prevents duplicate data using Subsets (a extension of Backbone Collection)
<!-- * Polymorphic Notification model that creates notifications for new albums, comments on your photos and comments on your comments. -->


## Still To Do

* Set up a mailer to confirm email addresses
* Pagination using Kaminari with infinate scroll
* Organize order of pictures useing JQueryUI
* Add the ability for users to reset passwords
* Backbonify notifications