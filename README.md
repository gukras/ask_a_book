# README
# ask_a_book - Gumroad challenge

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version.
Run this commands to install Ruby 7.1.1. 
Please, ignore them if you already have this rails version.
```
gem update
gem install rails -v 7.1.1
```

* System dependencies

Install Babel Plugin
```
npm install --save-dev @babel/plugin-proposal-private-methods
npm install --save-dev @babel/plugin-proposal-private-property-in-object
```

Run these commands to install dependencies
```
bundle install
rails webpacker:install
rails webpacker:install:react
```

* Configuration
Please, you should have your own environment variables file (.env) or create variables in Heroku or your deployment platform.
You can use .env.example as an example. 


* Database creation
Run this command to create the development and test databases
```
rails db:create
```

* Database initialization
```
rails db:migrate
```

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* Other Definitios
- Open Graph, Twitter and Google Tag Manager were not included in the project, as i expected to be a private project. 
- A different embedding model was used to avoid deprecation in some week, so the results may differ from original solution. 


