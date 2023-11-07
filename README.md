# ask_a_book - Gumroad challenge
## Setup - Local

1. Run this commands to install Rails 7.1.1. 
Please ignore them if you already have this version of Rails installed.
```
gem update
gem install rails -v 7.1.1
```

2. Install the Babel Plugin with these commands:
```
npm install --save-dev @babel/plugin-proposal-private-methods
npm install --save-dev @babel/plugin-proposal-private-property-in-object
```

3. Execute the following commands to install additional dependencies:
```
bundle install
rails webpacker:install
rails webpacker:install:react
```

4. Ensure you have your own `.env` file for environment variables, or set them up on Heroku or your chosen deployment platform.
Refer to `.env.example` for guidance.

5. Use this command to create the development and test databases. The command may differ when working in a production environment.
```
rails db:create
```

6. Migrate your database with the following command (adjust as needed for production environments):
```
rails db:migrate
```

7. Generate a user and password to access authenticated controllers. The password must be at least 6 characters long (modify the Devise configuration for enhanced security if desired).
```
rake 'setup:create_user[<email>, <password>]'
```

8. Generate an embeddings file from a PDF:
```
rake 'question:convert_pdf_to_embeddings[<file_name>]'
```

9. Run in two different terminals: 
```
rails s
 ./bin/webpack-dev-server
```

10. Open a browser in the following url: `localhost://3000`  (Port may vary according to your config)


## Deploy to Heroku

1. Create a Heroku app (If the name is already used, just choose a different one.): 

```
heroku create <your-app-name>
heroku addons:create heroku-postgresql:mini --app <your-app-name>
```

2. Add Heroku buildpacks before pushing
```
heroku buildpacks:add heroku/ruby
heroku buildpacks:add heroku/nodejs
```

3. Set config variables on Heroku to match your `.env`.
Database variables are automatically set on Heroku, DO NOT modify them

4. Push to Heroku:

```
git push heroku main
```

Deploy to Heroku with:
```
git push heroku main --no-verify
```
`no-verify` is added due to using Git LFS for the large embedding file.

4. Run migrations:
```
heroku rake db:migrate
heroku rake 'setup:create_user[<email>, <password>]'
heroku rake 'question:convert_pdf_to_embeddings[<file_name>]'
```

5. Change configurations
```
heroku ps:scale web=1
heroku domains:add <yourdomain>
```

6. Open App
```
heroku open
```

6. Common issues
If you have any issues with Node version on Heroku, try changing Node Version
```
heroku config:set NODE_VERSION=16.x -a askabook
```

## Other Definitios
1. Open Graph, Twitter, and Google Tag Manager were omitted from the project as it was anticipated to be private.
2. The Embedding model should be updated to a newer version, such as `text-embedding-ada-002`, before January 4, 2024, to prevent service interruptions.
3. The tokenizer function in Ruby may not be identical to the Python version but aims to be functionally equivalent.
4. Two runnable tasks were created: `question:convert_pdf_to_embeddings` and `question:convert_csv_to_embeddings`. This decision was due to the unavailability of the original `book.pdf`; thus, if someone encounters the same issue and possesses the `book.pdf.pages.csv` file, they can execute the embeddings task.
5. Refactoring was undertaken to reduce code repetition, particularly with OpenAI's get_embedding methods, ensuring a single instance of the OpenAI client per request.
6. Rails Admin and Devise were utilized for the authenticated section `/db`.
7. The `cors.rb` file is configured to allow origins set to *. This setting can be further restricted if necessary.
8. React components can also be integrated using `<%= react_component %>` within Rails views. Given the project's scope, both methods yield similar results; however, a different approach might be preferable for larger projects.
9. While some folders/files may be superfluous for this specific project, they have been retained to adhere to Rails conventions.
10. There are some warnings with new versions for example with npm that should be reviewed. 

