# Basic Board Game Collection

## Overview

Keep track of your board game collection, including which games you own and when you played them. This app was built by Josh Ellis for the Flatiron School Software Engineering program.

## Installation

1. Clone the repo.
2. Run `bundle install` to set up the dependencies.
3. Run `rake db:migrate` to set up the database.
4. Run `shotgun` to start up the server.
5. Visit the localhost address given to you by Shotgun in your browser.
  
## Demo

View a demo of this app on [Youtube](https://youtube.com/#) (to be added)

## Description

_This app is designed to meet the specifications given by Flatiron School (see "Flatiron Requirements" below)._

### Functionality

The app allows users to create accounts in order to view and manage a board game collections by creating, reading, updating, and destroying the board game objects associated with their account.

Users are also able to view a list of all the boardgames anyone has added to their account and browse which other users have added those games to their account. A user's profile page shows their collection.

### Data Structure

A board game `has_many` users and a user `has_many` board games, so it is necessary to have a join table mediating between the two that `belongs_to` each.

## Contributions

Issues and pull requests are welcome, though I'm not sure how much I'll be maintaining this project. Feel free to create your own fork and build on it as you see fit.

### Flatiron Requirements

#### Application

- [x] Use Sinatra to build the app
- [ ] Use ActiveRecord for storing information in a database
- [ ] Include more than one model class (e.g. User, Post, Category)
- [ ] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
- [ ] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
- [ ] Include user accounts with unique login attribute (username or email)
- [ ] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
- [ ] Ensure that users can't modify content created by other users
- [ ] Include user input validations
- [ ] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
- [ ] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

#### Version Control

- [ ] You have a large number of small Git commits
- [ ] Your commit messages are meaningful
- [ ] You made the changes in a commit that relate to the commit message
- [ ] You don't include changes in a commit that aren't related to the commit message

### License

Copyright (c) 2020 Josh Ellis - [MIT License](https://github.com/imjoshellis/sinatra-project/blob/master/LICENSE)
