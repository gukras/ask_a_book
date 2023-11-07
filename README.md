# README
# ask_a_book - Gumroad challenge

## Ruby version.
1. Run this commands to install Rails 7.1.1. 
Please ignore them if you already have this version of Rails installed.
```
gem update
gem install rails -v 7.1.1
```

## System dependencies

1. Install the Babel Plugin with these commands:
```
npm install --save-dev @babel/plugin-proposal-private-methods
npm install --save-dev @babel/plugin-proposal-private-property-in-object
```

2. Execute the following commands to install additional dependencies:
```
bundle install
rails webpacker:install
rails webpacker:install:react
```

## Configuration
1. Ensure you have your own `.env` file for environment variables, or set them up on Heroku or your chosen deployment platform.
Refer to `.env.example` for guidance.


## Database creation
1. Use this command to create the development and test databases. The command may differ when working in a production environment.
```
rails db:create
```

## Database initialization
1. Migrate your database with the following command (adjust as needed for production environments):
```
rails db:migrate
```

## User Setup
1. Generate a user and password to access authenticated controllers. The password must be at least 6 characters long (modify the Devise configuration for enhanced security if desired).
```
rake 'setup:create_user[<email>, <password>]'
```

## Create embeddings

1. Generate an embeddings file from a PDF:
```
rake 'question:convert_pdf_to_embeddings[<file_name>]'
```

* How to run the test suite

* Deployment instructions

* Other Definitios
1. Open Graph, Twitter, and Google Tag Manager were omitted from the project as it was anticipated to be private.
2. The Embedding model should be updated to a newer version, such as `text-embedding-ada-002`, before January 4, 2024, to prevent service interruptions.
3. The tokenizer function in Ruby may not be identical to the Python version but aims to be functionally equivalent.
4. Two runnable tasks were created: `question:convert_pdf_to_embeddings` and `question:convert_csv_to_embeddings`. This decision was due to the unavailability of the original `book.pdf`; thus, if someone encounters the same issue and possesses the `book.pdf.pages.csv` file, they can execute the embeddings task.
5. Refactoring was undertaken to reduce code repetition, particularly with OpenAI's get_embedding methods, ensuring a single instance of the OpenAI client per request.
6. Rails Admin and Devise were utilized for the authenticated section `/db`.
7. The `cors.rb` file is configured to allow origins set to *. This setting can be further restricted if necessary.
8. React components can also be integrated using `<%= react_component %>` within Rails views. Given the project's scope, both methods yield similar results; however, a different approach might be preferable for larger projects.
9. While some folders/files may be superfluous for this specific project, they have been retained to adhere to Rails conventions.

