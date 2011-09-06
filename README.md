Saphira
=======

Saphira is a file manager written for RoR using dragonfly. It's created for the great Railsyard CMS, but it's using the mountable engines introduced in rails 3.1, so it would be useable without RY as well.

Currently this project is under development and not finished at all but in order to have it under version control, it's already available on github.

Features
--------
* Create folders
* Upload files
* Tag files
* Automatically read EXIF data from images

To-Do
-----
* Image manipulation
  * A form helper for image cropping
  * Multiple named image versions
* WebDav access
* Search files

Requirements
------------
* [Rails 3.1.x](http://rubyonrails.org/)
* [dragonfly](https://github.com/markevans/dragonfly/): A Ruby Rack-based gem for on-the-fly processing - suitable for image uploading in Rails, Sinatra and much more! 
* [awesome\_nested\_set](https://github.com/collectiveidea/awesome_nested_set): An awesome replacement for acts\_as\_nested\_set and better\_nested\_set.
* [exifr](https://github.com/remvee/exifr/): EXIF Reader
* [friendly_id](https://github.com/norman/friendly_id): It allows you to create pretty URL’s and work with human-friendly strings as if they were numeric ids for ActiveRecord models.
* [acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on): A tagging plugin for Rails applications that allows for custom tagging along dynamic contexts.
* _And some more gems in development mode_

Installation
------------
Add the gem to your gemfile: `gem 'saphira', '~> 0.1.0.beta2'` and add `mount Saphira::Engine => "/saphira", :as => 'saphira'` to your `routes.rb` file to mount the engine. The file manager should be available at `http://localhost:3000/saphira` then.
