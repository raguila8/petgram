# Petgram

Petgram is a full stack instagram like web app. It is a photo sharing web application dedicated to pets. Petgram has all the instagram web functionalities with some added features, such as the ability to upload images in the browser and the ability to create different profiles for different pets with the same account.

[View Project](https://glacial-basin-59424.herokuapp.com/) 


## Built With

* [Ruby on Rails](http://rubyonrails.org/) - 5.1.5
* [PostgreSQL](https://www.postgresql.org/) - Used for productionn
* [SQLite](https://www.sqlite.org/index.html) - Used for development
* [Puma Web Server](https://github.com/puma/puma) 
* [Heroku PaaS](https://www.heroku.com/)
* [Devise Authentication](https://github.com/plataformatec/devise)
* [Amazon S3 cloud storage](https://aws.amazon.com/s3/) - Used to store images
* [SendGrid](https://sendgrid.com/) - Used for account recovery
* [carrierwave](https://github.com/carrierwaveuploader/carrierwave) - Used for image uploads
* [minimagick](https://github.com/minimagick/minimagick) - image processing library
* [Acts As Votable](https://github.com/ryanto/acts_as_votable) - Used for post likes
* [Bootstrap](http://getbootstrap.com/docs/3.3/)
* [jQuery](https://jquery.com/)
* [Sass](https://sass-lang.com/)

## Features

* Users can edit profile info, change email and password, and change avatar. Users have the option to choose from list of artistic animal icons.
* Users can add, delete and control different profiles for different pets using one account.
* Users can follow and unfollow other users.
* Users have a feed page where they can see their friends' most recent posts. 
* Implemented an infinite scroll with ajax where users can more easily navigate through posts by just scrolling down without having to click on any buttons.
* Users will recieve notifications if either one of their posts is liked or commented on, or if somone starts following them.
* Users can make posts with image and caption
* Users can delete their posts or edit them.
* Users can like and comment on any post. They can also delete their comment or unlike a post.
* Users have a discover page where they can add followers that they are not following. Users can also see the most popular recent posts. 
* Users can navigate through posts through a modal carousel interface or simply by going to the post's page.
* Users have their wn profile page where you can see their posts and their profile info such as followers, following, pet type, name and bio.

