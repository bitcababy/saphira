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
* WebDav access
* Search files

Requirements
------------
* Rails 3.1.x
* Some gems - check Gemfile

Installation
------------
Add the gem to your gemfile: `gem 'saphira', :git => 'git://github.com/spieker/saphira.git'` and add `mount Saphira::Engine => "/saphira", :as => 'saphira'` to your `routes.rb` file to mount the engine. The file manager should be available at `http://localhost:3000/saphira` then.