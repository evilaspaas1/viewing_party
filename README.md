# Viewing Party

## Table of Contents
- [Overview](#overview)
- [Getting Started](#getting-started)
    - [Ruby and Rails Versions](#ruby-and-rails-versions)
    - [Local Setup Instructions](#local-setup-instructions)
    - [Testing](#testing)
    - [Extras](#extras)
- [Design](#design)
    - [Schema](#schema)
    - [Refactor Example](#refactor-example)
    - [Future Design Ideas](#future-design-ideas)
- [Contributors](#contributors)
- [Additional Notes](#additional-notes)
    - [Using Heroku and Travis CI](#using-heroku-and-travis-CI)
    - [Acknowledgement](#acknowledgement)

## Overview
Viewing Party is a web application to search for movies and view their details (vote average, runtime, cast, summary, etc.). Once a movie is chosen, a registered user can create a viewing party event and invite friends to watch the movie together. Viewing Party requires basic authentication and consumes multiple endpoints from [The Movie Database API](https://www.themoviedb.org/documentation/api).

Check out our **[live site on Heroku](https://lit-waters-75295.herokuapp.com/).**

See our [Movie Database API - Viewing Party](https://www.postman.com/collections/19c0ddf08b87ea29f63d) collection in Postman:

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/19c0ddf08b87ea29f63d)

**Testing Status**
- Simplecov: 100% coverage
- RSpec:  88 tests, 0 failures

 **Features**
 
 Viewing Party demonstrates the following features: 
 - User authentication and authorization
 - User can add friends who exist in database
 - User can search movies by title
 - User can see top 40 movies from the day
 - User can see movie data for a specific movie
 - User can create watch parties and invite specific friends

## Getting Started
To get a copy of the project on your local machine for development and testing purposes, first confirm your Ruby and Rails versions, then follow the Local Setup Instructions!

### Ruby and Rails Versions
_[Click here](https://backend.turing.io/module3/misc/ruby_and_rails_versions) for instructions on how to check versions and install the correct ones if needed._ 

- Ruby 2.5.3
- Rails 5.2.4.3

### Local Setup Instructions

1. Clone [this repo](https://github.com/KieraAllen/viewing_party) into a new directory.
1. CD into `viewing_party`
1. Run `bundle install` to install gem packages 
1. Run `rails db:create` to set up the databases
1. Run `rails db:migrate` to add migrations
1. Run `rails db:seed` to seed with data
    1. Or run `rails db:{create,migrate,seed}` to complete the actions in one command

### Testing
- Run ALL tests: `bundle exec rspec`
- Run specific test file: `bundle exec rspec spec/<example directory>/<filename>`
- Run specific test: `bundle exec rspec:<test line number goes here>`

### Extras

**Wireframes**

Example wireframes for browser pages can be [found here](https://backend.turing.io/module3/projects/viewing_party/wireframes).
 
**Gems** 

- [`rspec-rails`](https://github.com/rspec/rspec-rails) - testing suite
- [`pry`](https://github.com/pry/pry) - runtime developer console
- [`capybara`](https://github.com/teamcapybara/capybara) - aids in application testing and interaction 
- [`simplecov`](https://github.com/simplecov-ruby/simplecov) - tracks test coverage
- [`shoulda-matchers`](https://github.com/thoughtbot/shoulda-matchers) - simplifies testing syntax
- [`launchy`](https://rubygems.org/gems/launchy/versions/2.5.0) - helper class for launching cross-platform applications
- [`bcrypt`](https://github.com/codahale/bcrypt-ruby) - encrypts passwords
- [`vcr`](https://github.com/vcr/vcr) - records test suite's HTTP interactions and replays them
- [`faraday`](https://github.com/lostisland/faraday) - HTTP client library that provides common interface over many adapters
- [`figaro`](https://github.com/laserlemon/figaro) - securely configures Rails apps
- [`rubocop-rails`](https://github.com/rubocop-hq/rubocop-rails) - enforces Rails best practices and coding conventions

**Project Board Clone**

To view the GitHub project board you can clone using conveyor belt, [click here](https://github.com/turingschool-examples/viewing_party/projects/1). To clone, follow these instructions:

1. [Click here](https://conveyorbelt.herokuapp.com/projects/oMq25tjQk1ec/clones/new) for the conveyor belt link.
1. You will be prompted to sign in using your GitHub credentials.
1. Fill out the “Who’s working on the project?” and “What e-mail should we send the finished board to?” questions.
1. Submit and the new project board should open automatically.

## Design

### Schema

![schema](https://i.ibb.co/T4Jwckx/vp-schema.png)

### Refactor Example

_Initial Movies Controller_
![original-movies-controller](https://user-images.githubusercontent.com/46658858/101684579-e084d480-3a23-11eb-8e89-f623943e1288.png)

_Final Movies Controller_
![final-movies-controller](https://user-images.githubusercontent.com/46658858/101723801-45631d80-3a6a-11eb-897a-08d44cf432cf.png)

### Future Design Ideas
If we were able to add to this project in the future, some features we could include are:
- CRUD functionality for friends and viewing parties
    - delete a friend, delete a viewing party, etc.
- Users have to give permission to be added as a friend  
- A friend would receive an email invite before they are added to a viewing party

## Contributors
- Austin Aspaas (he/him)
  - [GitHub: evilaspaas1](https://github.com/evilaspaas1)
- Kiera Allen (she/her)
  - [GitHub: kieraallen](https://github.com/KieraAllen)
- Shaunda Cunningham (she/her)
  - [GitHub: smcunning](https://github.com/smcunning)
  
## Additional Notes

### Using Heroku and Travis CI
1. Deploy to [Heroku](https://signup.heroku.com/login)
    - [Click here](https://devcenter.heroku.com/articles/getting-started-with-rails5#deploy-your-application-to-heroku) for instructions created by Heroku developers.
    - Or enter the following from your command line (while in the base directory of the project):
        - `heroku create`
        - `git push heroku master`
        - `heroku run rake db:migrate`
    - You will also need to set up any API keys manually for your Heroku production environment.

1. Continuous Integration with [Travis CI](https://travis-ci.com/signup)

- To start using Travis CI, make sure you have:
    - A [GitHub](https://github.com/), [Bitbucket](https://bitbucket.org/), [GitLab](https://about.gitlab.com/), or [Assembla](https://www.assembla.com/) account.
    - Owner permissions for a project hosted on GitHub, Bitbucket, GitLab, Assembla.

- Travis CI [Setup Instructions](https://docs.travis-ci.com/user/tutorial/?utm_source=help-page&utm_medium=travisweb#to-get-started-with-travis-ci-using-github)

**Important**
- Configure your API keys that are environment variables for the Travis environment (in this case, your `movies_api_key`). You can find configuration for environment variables by:
    - selecting your repository from the Travis dashboard
    - clicking More Options
        - choose 'Settings' from the drop-down menu
    - scroll to 'Environment Variables' and add the key

- Configure deployment to Heroku by filling in the api_key and app variables in your app's `.travis.yml` file.

- You can test that your Travis set up is working by pushing a commit to your repository.
    - should see a build triggered by the Travis dashboard
    - when the build is complete, you should see the change automatically deployed to Heroku

### Acknowledgement
The data used for this project was collected using the [official API documentation](https://developers.themoviedb.org/3/getting-started/introduction) provided by [The Movie Database](https://www.themoviedb.org/).
(While this project uses the TMDb API, it is not endorsed or certified by TMDb.)
