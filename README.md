# README
# ask_a_book - Gumroad challenge

## Ruby version.
1. Run this commands to install Ruby 7.1.1. 
Please, ignore them if you already have this rails version.
```
gem update
gem install rails -v 7.1.1
```

## System dependencies

1. Install Babel Plugin
```
npm install --save-dev @babel/plugin-proposal-private-methods
npm install --save-dev @babel/plugin-proposal-private-property-in-object
```

2. Run these commands to install dependencies
```
bundle install
rails webpacker:install
rails webpacker:install:react
```

## Configuration
1. Please, you should have your own environment variables file `.env` or create variables in Heroku or your deployment platform.
You can use `.env.example` as an example. 


## Database creation
1. Run this command to create the development and test databases. Command may change if you are working with a production environment.
```
rails db:create
```

## Database initialization
1. Run this command to migrate your database. Command may change if you are working with a production environment.

```
rails db:migrate
```

## User Setup
1. Create a user and password to access the authenticated controllers. Password must has at least 6 character (Modify devise configuration if you want a more secure platform.)

```
rake 'setup:create_user[<email>, <password>]'
```

## Create embeddings

1. Create embeddings file from a pdf

```
rake 'question:convert_pdf_to_embeddings[<file_name>]'
```

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* Other Definitios
1. Open Graph, Twitter and Google Tag Manager were not included in the project, as i expected to be a private project. 
2. Embedding model must be changed to a newer version like text-embedding-ada-002 before January 4, 2024 to avoid disruption of service
3. Tokenizer function in ruby is not exactly the same than python version, but should be equivalent. 
4. I decided to create two runnable task, question:convert_pdf_to_embeddings and question:convert_csv_to_embeddings. The reason of this definition was that i couldn't find the original book.pdf, so in order anyone face the same issue and has the csv version book.pdf.pages.csv, can run the embeddings task. 
5. Some refactors were made in order to avoid code repeatition with open AI get_embedding methods, and to ensure that only 1 instance of open AI client was used during a request.
6. Rails Admin and devise weres used for the authenticated section /db.
7. cors.rb origins are set to *. This can be restricted more if needed. 
8. React interaction can also be solved with <% =react_component %> from rails views. Due to the reduce scope of the project, both options have a similar impact. For a bigger project, the approach may be different. 

