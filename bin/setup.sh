#!/bin/sh

# set up all gem dependencies
bundle install --without production

# set up heroku git remote
git remote add heroku https://git.heroku.com/ratemypup.git

# set up db
rake db:setup
