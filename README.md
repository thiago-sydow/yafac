# YAFAC - Yet Another Fyber API Client

[![Build Status](https://travis-ci.org/thiago-sydow/yafac.svg?branch=master)](https://travis-ci.org/thiago-sydow/yafac)
[![Code Climate](https://codeclimate.com/github/thiago-sydow/yafac/badges/gpa.svg)](https://codeclimate.com/github/thiago-sydow/yafac)
[![Issue Count](https://codeclimate.com/github/thiago-sydow/yafac/badges/issue_count.svg)](https://codeclimate.com/github/thiago-sydow/yafac)
[![Test Coverage](https://codeclimate.com/github/thiago-sydow/yafac/badges/coverage.svg)](https://codeclimate.com/github/thiago-sydow/yafac/coverage)

Available at: https://yafac.herokuapp.com

Since it is a simple app/api I decided to go with Sinatra, and ERB for the views. I saw no reason to use Rails or other frameworks that would just add a lot of code unnecessarily.

I enjoyed doing it, and I liked to see how the signatures of request and response are made.

What could be better:
- Add gzip to improve response time
- If the application was bigger I would improve the structure to become more modular, and easy to add/maintain new things.
- Add client-side validation for inputs

Why I didn't do it:

Time was one reason but also I think that this is a reasonable version to be shown, and to add a lot more things would not add many value for now.

### Observation
1. There is a special treatment in `offer_client.rb:31` because Fyber API is returning HTTP 200 OK when a invalid page is informed. So the API has a bug, or the documentation is outdated.

## Running locally
```
$ git clone git@github.com:thiago-sydow/yafac.git
$ cd yafac/
$ bundle install
$ bundle exec unicorn -c ./config/unicorn.rb
```

You can see the app at `http://localhost:8080`

## Running Tests
```
$ bundle exec rake
```
